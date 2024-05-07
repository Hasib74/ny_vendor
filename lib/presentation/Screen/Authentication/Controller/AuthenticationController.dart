import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/repository/Local/DataSource/MySharedPreference.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/TokenController.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstant.dart';
import 'package:single_vendor_admin/presentation/Routes/AppsRoutes.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../data/repository/remote/Respositoris/VendorRemoteRepository.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController to = Get.find();

  //Repositories
  VendorRemoteRepository _vendorRepository = new VendorRemoteRepository();
  TextEditingController userNameText = new TextEditingController();
  TextEditingController userPasswordText = new TextEditingController();

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (ProfileController.to.vendorModel.value.address != null) {
      userNameText.text = ProfileController.to.vendorModel.value.email!;
      userPasswordText.text = ProfileController.to.vendorModel.value.password!;
    }
    // MySharedPreferenceController().getLoginToken();
  }

  Future<bool?> userLogin() async {
    if (LoginFormValidation()) {
      Map<String, String?> result = await _vendorRepository
          .userLoginAuthentication(userNameText.text, userPasswordText.text);
      if (result["success"]!.isBool == true) {
        return true;
      }
      return false;
    }
  }

  Future<bool?> userLogin1(BuildContext context) async {
    if (LoginFormValidation()) {
      Either<Response, Failure> response = await _vendorRepository
          .userLoginAuthentication1(userNameText.text, userPasswordText.text);
      response.fold((l) {
        //Map<String,dynamic> info = jsonDecode(l.body.toString());
        // print('login ok ${l.body[AppConstant.success]  }  ');
        if (l.body[AppConstant.success].toString() == 'true') {
          TokenController.to.token = l.body[AppConstant.token].toString();

          print('login ok ${TokenController.to.token}  ');

          MySharedPreferenceController.to
              .setLoginToken(TokenController.to.token!);

          ProfileController.to.getVendorProfile();

          Navigator.pushNamed(context, AppRoutes.VENDOR_HOME_PAGE);
          return true;
        } else {
          AppSnackBar.errorSnackbar(
              msg: l.body[AppConstant.message].toString());
          return false;
        }

        // Left(Response(body: response));
      }, (r) {
        AppSnackBar.errorSnackbar(msg: 'Login Failed 2');
        return false; // Right(NoConnectionFailure());
      });
    } else {
      if (userNameText.value.text.isEmpty) {
        AppSnackBar.errorSnackbar(msg: 'Email filed can not be empty.');
      } else {
        AppSnackBar.errorSnackbar(msg: 'Password filed can not be empty.');
      }
      return false; // Right(NoConnectionFailure());
    }
  }

  bool validateEmail(String sEmail) {
    if (sEmail == null) {
      return false;
    }
    bool emailValid =
        RegExp("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
            .hasMatch(sEmail);
    print('emails is valid or not ');
    print(emailValid);
    return emailValid;
  }

  LoginFormValidation() {
    if (userNameText.text.isEmpty) {
      errorSnackbar(msg: "User name is not Empty");
      return false;
    } else if (!validateEmail(userNameText.text)) {
      errorSnackbar(msg: "Email is not valid");
      return false;
    } else if (userPasswordText.text.isEmpty) {
      errorSnackbar(msg: "Password is not Empty");
      return false;
    } else {
      return true;
    }
  }

  void errorSnackbar({required String msg}) {
    Get.snackbar('$msg', "Error !",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.deepOrange[200],
        colorText: Colors.white);
  }

  void deleteVendorAccount() async {
    loading.value = true;
    var _response = await http.post(
        Uri.parse(
          URL.base_url + "delete/account",
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${TokenController.to.token}',
        });

    loading.value = false;

    print('delete account response ${_response.body}');

    if (_response.statusCode == 200) {
      AppSnackBar.successSnackbar(msg: "Account Deleted Successfully");
      MySharedPreferenceController.to.setLoginToken("");
      Get.offAllNamed(AppRoutes.AUTHENTICATION_PAGE);
    } else {
      AppSnackBar.errorSnackbar(msg: "Account Delete Failed");
    }
  }
}
