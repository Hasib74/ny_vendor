import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/Controller/AuthenticationController.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/OTP/Controller/OtpController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppBackgroudWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OtpController.to.startCountdownTimer();
    return AppBackgroundWidget(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpaces.spaces_height_5,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'OTP Code',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 10),
              child: Text(
                'OTP Code Sent To ${OtpController.to.phoneNumberText.value.text}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AppColors.orange),
              ),
            ),
            AppTextFieldWidget(
              hint: 'Enter OTP Code',
              textInputType: TextInputType.number,
              controller: OtpController.to.phoneOTPCodeText,
            ),
            AppSpaces.spaces_height_10,
            Obx(() {
              if (OtpController.to.isOTPScreenProcessing.value) {
                return Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: AppLoading(),
                  ),
                );
              } else {
                return AppButtonWidget(
                  leadingCenter: true,
                  title: 'Continue',
                  onTab: () {
                    if (OtpController
                        .to.phoneOTPCodeText.value.text.isNotEmpty) {
                      OtpController.to.phoneNumberOTPCodeVerification();
                    } else {
                      AppSnackBar.errorSnackbar(msg: "Please input OTP code.");
                    }
                  },
                );
              }
            }),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: Obx(() {
                  if (OtpController.to.countDownstart.value > 0) {
                    return Text(
                      'Remaining Time  ${OtpController.to.countDownstart.value}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'OTP Code Expired',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppButtonWidget(
                            title: "Resend",
                            leadingCenter: true,
                            backgroundColor: Colors.deepOrange,
                            width: 100,
                            onTab: () {
                              OtpController.to.resendOTPCode();
                            }),
                      ],
                    );
                  }
                })),
          ],
        ),
      ),
    );
  }
}
