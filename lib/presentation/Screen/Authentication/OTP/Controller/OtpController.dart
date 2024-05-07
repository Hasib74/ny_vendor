import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/repository/remote/Respositoris/VendorRemoteRepository.dart';
import 'package:single_vendor_admin/presentation/Routes/AppsRoutes.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/SignUp/Controller/VendorSignUpController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class OtpController extends GetxController {
  static OtpController to = Get.find();
  TextEditingController phoneNumberText = TextEditingController();
  TextEditingController phoneOTPCodeText = TextEditingController();

  RxString selectedCountryCode = '+880'.obs;
  List<String> allCountries = ["+880", "+1"];

  static String? userPhonoNo;

  RxBool isPhoneNoScreenProcessingInprogress = false.obs;
  RxBool isOTPScreenProcessing = false.obs;
  VendorRemoteRepository _authenticationRepository =
      new VendorRemoteRepository();
  RxInt countDownstart = 30.obs;
  RxInt phoneVerificationOTCode = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // loadCountries();
  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }

  /*
   ==============================================================
   ===================== Phone Number Screen ====================
   ==============================================================
   */
  Future phoneNumberVerification() async {
    generateRandomNumber();
    if (phoneNumberFormValidation() && phoneVerificationOTCode > 999) {
      //isPhoneNoScreenProcessingInprogress = true;

      String phoneNo = phoneNumberText.text;

      String countryCode = selectedCountryCode.substring(1);
      if (phoneNo.contains(countryCode)) {
        phoneNo = phoneNo.substring(countryCode.length);
      } else if (phoneNo[0] == '0') {
        phoneNo = phoneNo.substring(1);
      }
      phoneNo = countryCode + '' + phoneNo;
      userPhonoNo = phoneNo;
      print("phone number okay...${phoneNo}");

      OtpController.to.isOTPScreenProcessing.value = true;

      printInfo(
          info:
              "isOTPScreenProcessing  start  ${OtpController.to.isOTPScreenProcessing.value}");

      try {
        await sendOTPCode(userPhonoNo);
        OtpController.to.isOTPScreenProcessing.value = false;
      } catch (err) {
        printInfo(info: " ${e.toString()}");

        OtpController.to.isOTPScreenProcessing.value = false;

        Get.toNamed(AppRoutes.OTP_SCREEN);

        AppSnackBar.errorSnackbar(msg: "Message finished");
      }

      printInfo(
          info:
              "isOTPScreenProcessing  end ${OtpController.to.isOTPScreenProcessing.value}");
    }
  }

  sendOTPCode(String? phoneNumber) async {
    Either<dynamic, Failure> authResponse = await _authenticationRepository
        .sentOTPRemote(phoneNumber, phoneVerificationOTCode.toString());

    authResponse.fold((valueMap) {
      // print("phone otp send suscess "+l.body);

      isPhoneNoScreenProcessingInprogress.value = false;
      // Map valueMap = jsonDecode(l.body.toString());
      if (valueMap['success'] == 'true') {
        Get.toNamed(AppRoutes.OTP_SCREEN);
      } else {
        update();
        errorSnackbar(msg: "Network Error");

        Get.toNamed(AppRoutes.OTP_SCREEN);
      }
    }, (r) {
      isPhoneNoScreenProcessingInprogress.value = false;
      update();
      errorSnackbar(msg: "Network Error");
    });
  }

  phoneNumberFormValidation() {
    if (phoneNumberText.text.isEmpty || phoneNumberText.text.isBlank!) {
      errorSnackbar(msg: "Invalid Phone Number");
      return false;
    } else if (!phoneNumberText.text.isNum) {
      errorSnackbar(msg: "Invalid Phone Number");
      return false;
    }
    return true;
  }

  /*
   ==============================================================
   ===================== OTP Check =============================
   ==============================================================
   */

  phoneNumberOTPCodeVerification() async {
    // ASK :::  no function called

    print("OTP CODE :: ${phoneVerificationOTCode}");

    if (phoneOTPCodeText.value.text
        .endsWith(phoneVerificationOTCode.toString())) {
      Get.toNamed(AppRoutes.VENDOR_SIGN_UP, arguments: userPhonoNo);
    } else {
      AppSnackBar.errorSnackbar(msg: "OTP does not matched.");
    }

    return;
  }

  phoneNumberOTPCodeFormValidation() {
    if (phoneOTPCodeText.text.isEmpty) {
      print('opt error ${phoneOTPCodeText.text}');
      errorSnackbar(msg: "Invalid OTP Code");
      return false;
    }
    return true;
  }

  /*
   ==============================================================
   ===================== OTP Resend =============================
   ==============================================================
   */

  void resendOTPCode() {
    print('resend code ');
    generateRandomNumber();
    sendOTPCode(userPhonoNo);
    startCountdownTimer();
  }

  Timer? _timer;
  int timerIncrementStepValue = 0;

  void startCountdownTimer() {
    countDownstart.value = 40;
    if (_timer != null) {
      print('reset timer');
      _timer!.cancel();
    }
    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (countDownstart <= 0) {
          print('invalid timer');
          _timer!.cancel();
          _timer = null;
          phoneVerificationOTCode.value = 0;
          timerIncrementStepValue += 20;
        } else {
          countDownstart--;
          print('calling again ${countDownstart}');
        }
        update();
      },
    );
  }

  /*
   ==============================================================
   ===================== HELPER METHODS =============================
   ==============================================================
   */

  void loadCountries() async {
    Either<dynamic, Failure> authResponse =
        await _authenticationRepository.getCountries();
    authResponse.fold((valueMap) {
      // Map valueMap = jsonDecode(l.body);
      print(valueMap);
      List<String> list = <String>[];
      valueMap['message'].forEach((v) {
        list.add(v['phone_code'].toString());
        print(v['phone_code'].toString());
      });
      if (list.length > 2) {
        allCountries = list;
        update();
      }
    }, (r) {});
  }

  void errorSnackbar({required String msg}) {
     Get.snackbar('$msg', "Error !",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.deepOrange[200],
        colorText: Colors.white);
  }

  int generateRandomNumber() {
    Random random = new Random();
    int max = 9999, min = 1000;
    phoneVerificationOTCode.value = min + random.nextInt(max - min);
    print("range value is " + phoneVerificationOTCode.toString());
    return phoneVerificationOTCode.value;
  }
}
