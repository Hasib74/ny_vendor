import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/core/network/network_info.dart';
import 'package:single_vendor_admin/data/model/ProductNameModel.dart';
import 'package:single_vendor_admin/data/model/ProductOfferModel.dart';
import 'package:single_vendor_admin/data/model/ProductTypeModel.dart';
import 'package:single_vendor_admin/data/model/VendorModel.dart';
import 'package:single_vendor_admin/data/repository/Local/DataSource/MySharedPreference.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/ApiClient.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstant.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProducts/Controller/AddProductController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/EditProfile/EditProfileController/EditProfileController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';

import '../DataSource/URL.dart';

MySharedPreferenceController _mySharedPreferenceController = Get.find();

NetworkInfoController _networkInfoController = Get.find();

class VendorRemoteRepository {
  // demo data
  // String token = AppConstantData.token.token;
  // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYW5ib25ha2kuYmFhZGhhbi5jb21cL2FwaVwvdmVuZG9yLXJlZ2lzdHJhdGlvblwvcGhvbmUiLCJpYXQiOjE2MTI5NjI5NDUsImV4cCI6Mzc3Mjk2Mjk0NSwibmJmIjoxNjEyOTYyOTQ1LCJqdGkiOiJXYUJNZkNxazMwZzN0bFNOIiwic3ViIjo4LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Vm_s19r-cs73lsuG7hkSiJYSkMekELFVG19grkYnhrg";

  //var provider_id = 1;// AppConstantData.token.token;

  //VendorModel myProfileData = ProfileController.to.vendorModel.value;

  /*
    =====================================================================
    ======================== VENDOR  SIGNUP MODULE=================
    =====================================================================
  */

  Future<Either<Response, Failure>> signUp(
      VendorModel vendorModel, File profileImg) async {
    try {
      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.RequestWithFile(
            url: URL.vendor_registation,
            body: vendorModel.toJson() as Map<String, String>?,
            fileKey: ['vendor_image'],
            files: [profileImg],
            method: Method.POST,
            headerRequired: false);
        print("signup Response : ${response}");
        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<Response, Failure>> vendorProfile() async {
    try {
      if (await _networkInfoController.isConnected()) {
        dynamic response =
            await ApiClient.Request(url: URL.vendorProfile, enableHeader: true);

        print("profile api Response : ${response}");

        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print(" vendor profile api Error : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<Response, Failure>> updateVendorProfile({
    VendorModel? vendorModel,
    File? file,
    String? imageKey,
  }) async {
    try {
      if (await _networkInfoController.isConnected()) {
        if (EditProfileController.to.file == null) {
          Map _vendor_model = vendorModel!.toJson();

          var _body = {
            "vendor_image":
                ProfileController.to.vendorModel.value.vendorImage ?? ""
          };

          _vendor_model.addAll(_body);

          print("Update Profile ${_vendor_model}");

          dynamic response = await ApiClient.Request(
              enableHeader: true,
              url: URL.vendorProfileUpdate,
              body: jsonEncode(_vendor_model),
              method: Method.POST);

          print("Response : ${response}");

          return Left(Response(body: response));
        } else {
          dynamic response = await ApiClient.RequestWithFile(
              files: file != null ? [file] : [],
              fileKey: file != null ? ["${imageKey}"] : [],
              url: URL.vendorProfileUpdate,
              body: vendorModel!.toJson() as Map<String, String>?,
              headerRequired: true,
              method: Method.POST);

          print("Response : ${response}");

          return Left(Response(body: response));
        }
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> updateVendorLocation({
    required LatLng latLng,
  }) async {
    try {
      Map _body = {
        "lat_value": latLng.latitude,
        "long_value": latLng.longitude,
      };

      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            enableHeader: true,
            url: URL.updateVendorLocation,
            body: jsonEncode(_body),
            method: Method.POST);

        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }

  /*
    =====================================================================
    ======================== VENDOR  AUTHENTICATION MODUL================
    =====================================================================
  */

  Future<bool> sendPhoneVerificationOTPCode(String phoneno) async {
    String token = "";
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    String serverUrl = URL.phone_no_verificaton;

    Map<String, String> parameter = {'phoneno': phoneno};
    String queryString = Uri(queryParameters: parameter).query;
    var requestUrl = serverUrl + '?' + queryString;
    http.Response response =
        await http.get(Uri.parse(requestUrl), headers: header);

    var jsonResp = convert.jsonDecode(response.body);
    print("Server Response" + jsonResp);

    if (jsonResp['status_code'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Either<dynamic, Failure>> getCountries() async {
    try {
      if (await _networkInfoController.isConnected()) {
        print("SUB BODY country ");
        dynamic response = await ApiClient.Request(
            url: URL.country_list, // "${URL.country_list}",
            enableHeader: false,
            body: null,
            method: Method.GET);
        print("country url  ${URL.country_list}  response  ${response}");
        return Left(response);
      } else {
        print("network error is occured");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> sendAccountRecoveryPassword(
      String? phoneNo) async {
    try {
      if (await _networkInfoController.isConnected()) {
        print("Sub body Account Recovery ${phoneNo}");
        dynamic response = await ApiClient.Request(
            url: URL.account_recovery,
            enableHeader: false,
            body: {'phone': phoneNo},
            method: Method.POST);
        return Left(response);
      } else {
        print("Network error.........");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error.......................... : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> sentOTPRemote(
      String? phoneNo, String OTPCode) async {
    try {
      if (await _networkInfoController.isConnected()) {
        AppSnackBar.successSnackbar(msg: "OTP CODE IS :: ${OTPCode}");

        print("SUB BODY OTP Send ${phoneNo} code ${OTPCode}");
        dynamic response = await ApiClient.Request(
            url:
                "${URL.phone_no_verificaton}?phoneno=${phoneNo}&otpcode=${OTPCode}",
            //ApiUrls.phone_no_verificaton,//
            enableHeader: false,
            body: {'phoneno': phoneNo, 'otpcode': OTPCode},
            method: Method.GET);
        return Left(response);
      } else {
        print("network error is occured");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<bool> checkPhoneVerficationOTPCode(
      String phoneNo, String OTPCode) async {
    bool result = false;
    Map<String, String> bodyData = {"phoneno": phoneNo, "otpcode": OTPCode};
    try {
      dynamic response = await ApiClient.Request(
          url: URL.phone_verfication_OTP_checking,
          body: bodyData,
          method: Method.POST);

      if (response["error"] != null) {
        Get.snackbar(
          "Error !!!",
          response["error"].toString(),
        );
      } else {
        print("api done ");
        result = true;
      }
    } catch (err) {}
    return result;
  }

  Future<Either<Response, Failure>> vendorProfile1() async {
    try {
      if (await _networkInfoController.isConnected()) {
        dynamic response =
            await ApiClient.Request(url: URL.vendorProfile, enableHeader: true);

        print("Response : ${response}");

        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print(" vendor profile api Error : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<Response, Failure>> userLoginAuthentication1(
      String username, String pass) async {
    // bool result = false;
    Map<String, String> responseResult = {};

    Map<String, String> bodyData = {"email": username, "password": pass};
    try {
      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.userLoginAuthentication,
            body: bodyData,
            method: Method.POST,
            enableHeader: false);
        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print('exception occured for login ');
      return Right(NoConnectionFailure());
    }
  }

  Future<Map<String, String?>> userLoginAuthentication(
      String username, String pass) async {
    bool result = false;
    Map<String, String> responseResult = {};

    Map<String, String> bodyData = {"email": username, "password": pass};
    try {
      dynamic response = await ApiClient.Request(
          url: URL.userLoginAuthentication,
          body: bodyData,
          method: Method.POST,
          enableHeader: false);
      // print(response);
      if (response["error"] != null) {
        print("api error " + response["error"]);
        Get.snackbar(
          "Error !!!",
          response["error"].toString(),
        );
        return {"success": "false", "error": response["error"]};
        ;
      } else {
        print("api done " + response["token"]);
        _mySharedPreferenceController.setLoginToken(response["token"]);
        print(_mySharedPreferenceController.getLoginToken());
        return {"success": "true", "error": ""};
        ;
      }
    } catch (err) {
      return {"success": "false", "error": err.toString()};
    }
  }

  /*
    =====================================================================
    ======================== VENDOR  PRODUCT TYPE MODULE=================
    =====================================================================
  */
  Future<List<ProductTypeModel>> getAllProductTypesList() async {
    return fetchAllProductTypes(http.Client());
  }

  List<ProductTypeModel> parseProductTypes(String responseBody) {
    final parsed = jsonDecode(responseBody);
    print(parsed["message"]);
    return parsed["message"]
        .map<ProductTypeModel>((json) => ProductTypeModel.fromJson(json))
        .toList();
  }

  Future<List<ProductTypeModel>> fetchAllProductTypes(
      http.Client client) async {
    var provider_id =
        ProfileController.to.vendorModel.value.service_provider_id;
    print("vendor id is " + provider_id.toString());
    final response = await client.get(Uri.parse(
        URL.getProviderAllProductTypes + '/' + provider_id.toString()));

    var url = URL.getProviderAllProductTypes + '/' + provider_id.toString();

    printInfo(info: "Product Request URL ${url}");

    printInfo(info: "Product Type Response ${response.body}");
    return parseProductTypes(response.body);
  }

  Future<Either<Response, Failure>> addNewProductTypeInfo(
      productTypeName, serviceCategoryId, providerId, File image,
      {String? imageUrl, bool isUpdate = false, int? productId}) async {
    print("Is update : ${isUpdate}");
    printInfo(
        info:
            "ProfileController.to.vendorModel.value.service_provider_id ::: ${ProfileController.to.vendorModel.value.service_provider_id}");

    Map<String, String>? apiBody = {
      if (productId != null) "id": productId.toString(),
      "product_type_name": productTypeName,
      "service_type_id": serviceCategoryId.toString(),
      "is_active": "1",
      "service_provider_id":
          ProfileController.to.vendorModel.value.service_provider_id.toString(),
      if (imageUrl != null && imageUrl.isNotEmpty) "image": imageUrl,
    };

    try {
      if (await _networkInfoController.isConnected()) {
        //  dynamic response = await http.put(Uri.parse())

        dynamic response = await ApiClient.RequestWithFile(
            url: isUpdate ? URL.updateProviderProductTypes : URL.addProductType,
            body: apiBody,
            method: /*isUpdate ? Method.PUT :*/ Method.POST,
            files: image.path.isNotEmpty ? [image] : [],
            fileKey: ["image"],
            headerRequired: true);
        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      return Right(ServerFailure());
    }
  }

  Future<Either<Response, Failure>> deleteAProductType(productTypeId) async {
    int? provider_id =
        ProfileController.to.vendorModel.value.service_provider_id;

    try {
      final apiBody = convert.jsonEncode(
          {"id": productTypeId, "service_provider_id": provider_id});

      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.deleteProviderProductTypes,
            body: apiBody,
            method: Method.POST,
            enableHeader: true);
        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      return Right(ServerFailure());
    }
  }

/*  Future<Either<Response, Failure>> updateAProductType(
      productTypeName, productTypeId , File? file, String? imageUrl ) async {
    bool result = false;
    Map<String, dynamic> bodyData = {
      "id": productTypeId,
      "product_type_name": productTypeName ,

    };

    try {
      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.updateProviderProductTypes,
            body: convert.jsonEncode(bodyData),
            method: Method.POST,
            enableHeader: true);
        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      return Right(ServerFailure());
    }
  }*/

  /*
    =====================================================================
    ========================VENDOR PRODUCT NAME MODULE===================
    =====================================================================
  */

  Future<Either<Response, Failure>> addProductInformation(
      name,
      code,
      description,
      product_typeId,
      price,
      imagePath,
      isactive,
      offer,
      File imageFile) async {
    try {
      final Map<String, String> apiBody = {
        "product_name": name.toString(),
        "code": code.toString(),
        "price": price.toString(),
        "product_type_id": product_typeId.toString(),
        "description": description.toString(),
        "is_active": isactive.toString(),
        "offer_amount": offer,
      };

      printInfo(info: "The Body : ${apiBody}");
      printInfo(info: "The Image : ${imageFile}");

      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.RequestWithFile(
            url: URL.addNewProduct,
            body: apiBody,
            headerRequired: true,
            fileKey: [imagePath],
            files: [imageFile]);
        /*   dynamic response = await ApiClient.Request(
            url: URL.addNewProduct,
            body: apiBody,
            method: Method.POST,
            enableHeader: true);*/

        AddProductController.to.imageUrl.value = "";
        AddProductController.to.productSelectedImage.value = XFile("");
        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Errror :: ${err.toString()}");

      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> updateProductInformation(
      id,
      name,
      code,
      description,
      product_typeId,
      price,
      imagePath,
      imageUrl,
      isactive,
      offer,
      File imageFile) async {
    try {
      printInfo(
          info:
              "Image url .......................  ${imageUrl}   && image file is ${imageFile}");

      final Map<String, String> apiBody = {
        "product_name": name.toString(),
        "code": code.toString(),
        "price": price.toString(),
        "product_type_id": product_typeId.toString(),
        "description": description.toString(),
        "is_active": isactive.toString(),
        "imagePath": imageUrl.toString(),
        "offer_amount": offer.toString(),
        "product_name_id": id.toString()
      };

      printInfo(info: "The Update Body : ${apiBody}");
      printInfo(
          info:
              "The Update Image : ${imageFile.toString().endsWith("File: ''")}");

      if (await _networkInfoController.isConnected()) {
        dynamic response;
        if (imageFile.toString().endsWith("File: ''")) {
          response = await ApiClient.Request(
              url: URL.updateProduct + "${id}",
              body: jsonEncode(apiBody),
              method: Method.POST,
              enableHeader: true);

          print("The update response :: ${response}");
        } else {
          try {
            print("Waiting for upload ..........");
            response = await ApiClient.RequestWithFile(
                url: URL.updateProduct + "${id}",
                body: apiBody,
                headerRequired: true,
                fileKey: [imagePath],
                files: [imageFile]);

            print("Product Update response ::: ${response}");
          } catch (err) {
            printInfo(info: "Product Update Error ::: ${err.toString()}");
          }
        }

        /*   dynamic response = await ApiClient.Request(
            url: URL.addNewProduct,
            body: apiBody,
            method: Method.POST,
            enableHeader: true);*/

        AddProductController.to.isUpdate(false);

        AddProductController.to.imageUrl.value = "";
        AddProductController.to.productSelectedImage.value = XFile("");

        print("Response.................  ${response}");

        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Errror ............ :: ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<Response, Failure>> deleteAProductName(int? productId) async {
    try {
      final apiBody = convert.jsonEncode({"product_name_id": productId});

      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.deleteAProduct,
            body: apiBody,
            method: Method.POST,
            enableHeader: true);
        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      return Right(ServerFailure());
    }
  }

  Future<Either<Response, Failure>> updateProductStock(
      int? productId, qty) async {
    print("The quantity....................  ${qty}");
    try {
      final apiBody =
          convert.jsonEncode({"product_name_id": productId, 'quantity': qty});

      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.updateProductStock,
            body: apiBody,
            method: Method.POST,
            enableHeader: true);
        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      return Right(ServerFailure());
    }
  }

  Future<Either<Response, Failure>> addProductStock(int? productId, qty) async {
    print("The quantity....................  ${qty}");
    try {
      final apiBody =
          convert.jsonEncode({"product_name_id": productId, 'quantity': qty});

      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.addProductStock,
            body: apiBody,
            method: Method.POST,
            enableHeader: true);
        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      return Right(ServerFailure());
    }
  }

  Future<ProductNameModel?> getProviderProductNamesList() async {
    ProductNameModel? _value = new ProductNameModel();

    try {
      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.getProviderAllProductNames,
            body: null,
            method: Method.GET,
            enableHeader: true);

        try {
          _value = ProductNameModel.fromJson(response);
        } catch (err) {
          printInfo(info: "ProductNameModel error ::: ${err.toString()}");
        }
      } else {
        _value = null;

        AppSnackBar.errorSnackbar(
            msg: "Please check your internet connection ");
      }
    } catch (err) {
      print('Vendor all list error   ${err.toString()}');
      _value = null;
    }

    return _value;
  }

  /*
    =====================================================================
    ========================VENDOR OFFER ===================
    =====================================================================
  */
  Future<Either<Response, Failure>> saveVendorProductOffer(
      name, code, description, amount, offer_unit) async {
    try {
      final apiBody = convert.jsonEncode({
        "name": name,
        "code": code,
        "amount": amount,
        "service_provider_id": ProfileController.to.vendorModel.value.id,
        "description": description,
        "offer_unit": offer_unit,
        "is_active": 1
      });

      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.addVendorOffer,
            body: apiBody,
            method: Method.POST,
            enableHeader: true);
        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      return Right(ServerFailure());
    }
  }

  Future<Either<Response, Failure>> updateVendorOfferDetails(
      ProductOfferModel anOffer) async {
    try {
      final apiBody = convert.jsonEncode({
        "id": anOffer.offerId,
        "name": anOffer.offerName,
        "code": anOffer.offerCode,
        "amount": anOffer.offerAmount,
        "service_provider_id": ProfileController.to.vendorModel.value.id,
        "description": anOffer.offerDescription,
        "offer_unit": anOffer.offerUnit,
        "is_active": 1
      });

      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.udateVendorOffer,
            body: apiBody,
            method: Method.POST,
            enableHeader: true);
        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      return Right(ServerFailure());
    }
  }

  Future<ProductOfferModel?> getVendorOfferInformation() async {
    try {
      ProductOfferModel myOffer = new ProductOfferModel();
      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.getVendorOffer,
            body: null,
            method: Method.GET,
            enableHeader: true);
        if (response[AppConstant.success].toString() == 'true' &&
            response['status'].toString() == '200') {
          var list = response["message"]
              .map<ProductOfferModel>(
                  (json) => ProductOfferModel.fromJson(json))
              .toList();
          return list[0];
        } else {
          print('vendor offer not found ');
          return null;
        }
      } else {
        print('network error');
        return null;
      }
    } catch (err) {
      print('exception  error');
      return null;
    }
  }

  Future<Either<dynamic, Failure>> updateNewPassword(body) async {
    try {
      if (await _networkInfoController.isConnected()) {
        var response = await ApiClient.Request(
            method: Method.POST,
            body: body,
            url: "${URL.changePassword}",
            enableHeader: true);
        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());

      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> creteBankInfo(body) async {
    try {
      if (await _networkInfoController.isConnected()) {
        var response = await ApiClient.Request(
            method: Method.POST,
            body: body,
            url: "${URL.createBankInfo}",
            enableHeader: true);
        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());

      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> updateBankInfo(body) async {
    try {
      if (await _networkInfoController.isConnected()) {
        var response = await ApiClient.Request(
            method: Method.POST,
            body: body,
            url: "${URL.updateBankInfo}",
            enableHeader: true);
        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());

      return Right(ServerFailure());
    }
  }

  Future<Either<Response, Failure>> getBankInfo() async {
    try {
      if (await _networkInfoController.isConnected()) {
        print("Url : =>  ${URL.getBankInfo}");
        dynamic response = await ApiClient.Request(
            url: "${URL.getBankInfo}", enableHeader: true);
        print("Response from remote ${response}");
        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());

      return Right(ServerFailure());
    }
  }

  /*
    =====================================================================
    ========================VENDOR ADD OFFER===================
    =====================================================================
  */

  Future<Either<Response, Failure>> addOffer(body) async {
    try {
      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.addOffer,
            enableHeader: true,
            body: jsonEncode(body),
            method: Method.POST);
        print("Response : ${response}");

        return Left(Response(body: response));
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }

  /*
    =====================================================================
    ========================VENDOR CREDENTIAL INFORMATION===================
    =====================================================================
  */
  Future<Either<Response, Failure>>? addCredentialInformation() {}
}
