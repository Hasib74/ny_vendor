import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/Token.dart';
import 'package:single_vendor_admin/data/model/VendorModel.dart';
import 'package:single_vendor_admin/data/repository/Repositories/VendorRepository.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/TokenController.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstant.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstantData.dart';
import 'package:single_vendor_admin/presentation/Constant/ExceptionHandle.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  //Vendor Repository Initiaization

  static EditProfileController to = Get.find();

  VendorRepository _vendorRepository = new VendorRepository();

  TextEditingController userNameController = new TextEditingController();
  TextEditingController vendorNameController = new TextEditingController();
  TextEditingController shopNameController = new TextEditingController();
  TextEditingController openingTimeController = new TextEditingController();
  TextEditingController closingTimeController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool? isActive;

  Rx<File>? file = File("").obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    // getMyProfileInformation();
  }

  intialData() {
    userNameController.text =
        ProfileController.to.vendorModel.value.userName ?? "";
    vendorNameController.text =
        ProfileController.to.vendorModel.value.fullName ?? "";
    shopNameController.text =
        ProfileController.to.vendorModel.value.shopName ?? "";
    openingTimeController.text =
        ProfileController.to.vendorModel.value.openingTime ?? "";
    closingTimeController.text =
        ProfileController.to.vendorModel.value.closingTime ?? "";
    emailController.text = ProfileController.to.vendorModel.value.email ?? "";
    passwordController.text =
        ProfileController.to.vendorModel.value.password ?? "";
  }

  bool _isChangedData() {
    return /*!userNameController.value.text
            .endsWith(ProfileController.to.vendorModel.value.userName) ||*/
        !vendorNameController.value.text
                .endsWith(ProfileController.to.vendorModel.value.fullName!) ||
            !shopNameController.value.text
                .endsWith(ProfileController.to.vendorModel.value.shopName!) ||
            !openingTimeController.value.text.endsWith(
                ProfileController.to.vendorModel.value.openingTime!) ||
            !closingTimeController.value.text.endsWith(
                ProfileController.to.vendorModel.value.closingTime!) ||
            !emailController.value.text
                .endsWith(ProfileController.to.vendorModel.value.email!);
  }

  setFile(File file) {
    this.file?.value = file;
    update();
  }

  setIsActiveStatus(bool isActive) {
    this.isActive = isActive;
    update();
  }

// unused method
  void getMyProfileInformation() {
    print("progile api calling with token is " +
        TokenController.to.token.toString());
    _vendorRepository.vendorProfile();
  }

  Future<bool> vendorUpdateProfile() async {
    bool isSuccess = false;

    printInfo(info: "Is changed ::: ${_isChangedData()}");

    // if (!_isChangedData()) {
    //   AppSnackBar.errorSnackbar(msg: "Please change filed data before update.");
    // }
    if (signUpFormValidation() == true /*&& _isChangedData() == true*/) {
      loading(true);

      VendorModel vendorModel = new VendorModel(
        userName: userNameController.value.text,
        fullName: vendorNameController.value.text,
        // address: "Dhaka",
        // description: "omk",
        openingTime: openingTimeController.value.text,
        closingTime: closingTimeController.value.text,
        country_id: "+88",
        //delivery_charge: "200",
        // lat_value: "18.0",
        // long_value: "17.0",
        shopName: shopNameController.value.text,
        email: emailController.value.text,
      );

      Either<Response, Failure>? response =
          await _vendorRepository.updateVendorProfile(
              vendorModel: vendorModel,
              file: file?.value,
              imageKey: "vendor_image");

      response?.fold((l) {
        printInfo(info: "Status Code is : : : ${l.statusCode}");

        loading(false);

        if (l.body[AppConstant.success] != true) {
          if (l.body[AppConstant.error] != null) {
            file = null;

            AppSnackBar.successSnackbar(
                msg: l.body[AppConstant.error].toString());
          } else {
            AppSnackBar.successSnackbar(
                msg: l.body[AppConstant.message].toString());
          }
        } else {
          isSuccess = true;
        }
      }, (r) {
        loading(false);

        ExceptionHandle.exceptionHandle(r);

        isSuccess = false;
      });
    } else {
      isSuccess = false;
    }

    return isSuccess;
  }

  signUpFormValidation() {
    if (vendorNameController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Email can not be empty");
      return false;
    } else if (shopNameController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Shop Name can not be empty");
      return false;
    } else if (openingTimeController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Opening Time can not be empty");
      return false;
    } else if (closingTimeController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Closing Time can not be empty");
      return false;
    } else if (emailController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Email can not be empty");
      return false;
    }
    /*else if (passwordController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Password can not be empty");
      return false;
    }*/
    else {
      return true;
    }
  }
}
