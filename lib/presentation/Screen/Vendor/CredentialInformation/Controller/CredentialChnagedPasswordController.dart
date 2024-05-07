
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:single_vendor_admin/data/repository/Repositories/VendorRepository.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';
import 'package:get/get.dart';

class CredentialChangedPasswordController extends GetxController {
  
  TextEditingController currentPasswordController = new TextEditingController();
  TextEditingController newPasswordPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  static CredentialChangedPasswordController to = Get.find();

  VendorRepository _vendorRepository = new VendorRepository();

  RxBool loading = false.obs;

  updatePassword() async {
    if (validation()) {
      
      loading.value = true;

      Map _body = {
        "current_password": currentPasswordController.value.text,
        "new_password": newPasswordPasswordController.value.text,
        "new_password_confirmation": confirmPasswordController.value.text,
      };

      var response = await _vendorRepository.updatePassword(jsonEncode(_body));
      response.fold((l) {
        printInfo(
            info: "Response ============> ${l["success"]}");

        if (l["success"].toString().endsWith("true")) {
          AppSnackBar.successSnackbar(msg: l["message"]);
        } else {
          AppSnackBar.errorSnackbar(msg: l["message"]);
        }
      }, (r) => print("Right ======>${r}"));

      loading.value = false;
    }
  }



  bool validation() {
    bool isValidation;

    if (currentPasswordController.value.text.isEmpty) {
      isValidation = false;
      AppSnackBar.errorSnackbar(msg: "Current Password can not be empty");
    } else if (currentPasswordController.value.text.length < 6) {
      isValidation = false;
      AppSnackBar.errorSnackbar(msg: "Password can not less then 6 character");
    } else if (newPasswordPasswordController.value.text.isEmpty) {
      isValidation = false;
      AppSnackBar.errorSnackbar(msg: "New Password can not be empty");
    } else if (newPasswordPasswordController.value.text.length < 6) {
      isValidation = false;
      AppSnackBar.errorSnackbar(msg: "Password can not less then 6 character");
    } else if (confirmPasswordController.value.text.isEmpty) {
      isValidation = false;
      AppSnackBar.errorSnackbar(msg: "Confirm Password can not be empty");
    } else if (confirmPasswordController.value.text.length < 6) {
      isValidation = false;
      AppSnackBar.errorSnackbar(msg: "Password can not less then 6 character");
    } else if (newPasswordPasswordController.value.text !=
        confirmPasswordController.value.text) {
      isValidation = false;
      AppSnackBar.errorSnackbar(
          msg: "New password and confirm password is not correct !!!");

    } else {
      isValidation = true;
    }

    return isValidation;
  }
}