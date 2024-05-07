import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/Token.dart';
import 'package:single_vendor_admin/data/model/VendorModel.dart';
import 'package:single_vendor_admin/data/repository/Local/DataSource/MySharedPreference.dart';
import 'package:single_vendor_admin/data/repository/Repositories/VendorRepository.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/ApiClient.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/TokenController.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstant.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstantData.dart';
import 'package:single_vendor_admin/presentation/Constant/ExceptionHandle.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/Controller/AuthenticationController.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/OTP/Controller/OtpController.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/OTP/PhoneAuthentication.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:single_vendor_admin/presentation/utils/AppAseets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recursive_regex/recursive_regex.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';
import 'package:get/get.dart';

MySharedPreferenceController _mySharedPreferenceController = Get.find();

class VendorSignUpController extends GetxController {
  static VendorSignUpController to = Get.find();

  RxBool valuefirst = false.obs;

  //Text Controller
  TextEditingController vendorNameController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController openingTimeController = new TextEditingController();
  TextEditingController closingTimeController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController shopNameController = new TextEditingController();
  TextEditingController vendorImageController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController c_passwordController = new TextEditingController();

  File? vendorProfileImage;

  //Repositories
  VendorRepository _vendorRepository = new VendorRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    phoneNumberController.text = OtpController.userPhonoNo!;
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

  Future<bool> vendorSignUp() async {
    bool isSuccess = false;

    if (signUpFormValidation()) {
      VendorModel vendorModel = new VendorModel(
          fullName: vendorNameController.value.text,
          description: descriptionController.value.text,
          phoneNumber: phoneNumberController.value.text,
          closingTime: closingTimeController.value.text,
          openingTime: openingTimeController.value.text,
          shopName: shopNameController.value.text,
          email: emailController.value.text,
          password: passwordController.value.text,
          c_password: c_passwordController.value.text,
          userName: userNameController.value.text,
          address: addressController.value.text);

      Either<Response, Failure> response = await (_vendorRepository.vendorSignUp(
          vendorModel, File(vendorProfileImage!.path)) as FutureOr<Either<Response<dynamic>, Failure>>);

      response.fold((l) {
        if (l.body[AppConstant.success] != true) {
          if (l.body[AppConstant.error] != null) {
            AppSnackBar.errorSnackbar(
                msg: l.body[AppConstant.error].toString());
          } else {
            AppSnackBar.errorSnackbar(
                msg: l.body[AppConstant.message].toString());
          }
        } else {
          print('signup comleted');
          print(l.body);

          TokenController.to.token = l.body['token'];
          _mySharedPreferenceController.setLoginToken(l.body['token']);

          ProfileController.to.getVendorProfile();

          isSuccess = true;
        }
      }, (r) {
        ExceptionHandle.exceptionHandle(r);

        isSuccess = false;
      });
    } else {
      isSuccess = false;
    }

    return isSuccess;
  }

  void setVendorProfileImage() {
    update();
  }

  signUpFormValidation() {
    if (emailController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Email can not be empty.");
      return false;
    } else if (!validateEmail(emailController.text)) {
      AppSnackBar.errorSnackbar(msg: "Email is not valid.");
      return false;
    } else if (vendorNameController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Vendor Name can not be empty.");
      return false;
    } else if (addressController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Address can not be empty.");
      return false;
    } else if (openingTimeController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Opening Time can not be empty.");
      return false;
    } else if (closingTimeController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Closing Time can not be empty.");
      return false;
    } else if (phoneNumberController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Phone Number can not be empty.");
      return false;
    } else if (shopNameController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Shop Name can not be empty.");
      return false;
    } else if (vendorProfileImage == null || vendorProfileImage!.path == null) {
      AppSnackBar.errorSnackbar(msg: "Image file can not be empty.");
      return false;
    } else if (valuefirst.value == false) {
      AppSnackBar.errorSnackbar(msg: "Check the trams and condition.");
      return false;
    } else {
      return true;
    }
  }

  updateCheckBox() {
    print('calling for chekc box');
    update();
  }
}
