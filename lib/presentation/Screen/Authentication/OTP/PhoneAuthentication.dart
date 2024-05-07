import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/OTP/Controller/OtpController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppBackgroudWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:get/get.dart';

class PhoneAuthentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  OtpController.to.phoneNumberText.text = "8801731540704";

    // OtpController.to.loadCountries();

    return AppBackgroundWidget(
      child: Obx(() => AbsorbPointer(
            absorbing: OtpController.to.isOTPScreenProcessing.value,
            child: SingleChildScrollView(
              child: Container(
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpaces.spaces_height_5,
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Select Country Code',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          createCountryDropdownlist(),
                          createPhoneNumberTextField(),
                        ],
                      ),
                    ),
                    AppSpaces.spaces_height_10,
                    Obx(() {
                      print("is loading " +
                          OtpController.to.isOTPScreenProcessing.toString());
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
                            //  Get.toNamed(AppRoutes.DRAWERMENHOMESCREEN);

                            if (OtpController
                                    .to.phoneNumberText.value.text.isNotEmpty &&
                                OtpController.to.phoneNumberText.text.isNum) {
                              OtpController.to.phoneNumberVerification();
                            } else {
                              AppSnackBar.errorSnackbar(
                                  msg: "Please input your phone number ...");
                            }
                          },
                        );
                      }
                    })
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget createPhoneNumberTextField() {
    return Expanded(
      child: AppTextFieldWidget(
        hint: 'Enter your phone number',
        textInputType: TextInputType.phone,
        controller: OtpController.to.phoneNumberText,
      ),
    );
  }

  Widget createCountryDropdownlist() {
    return Obx(() {
      return Container(
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.gray),
        ),
        child: Center(
          child: DropdownButton(
            value: OtpController.to.selectedCountryCode.toString(),
            onChanged: (dynamic newValue) {
              print(newValue);
              OtpController.to.selectedCountryCode.value = newValue;
              //OtpController.to.updateSelectedMenuItem(newValue);
            },
            items: OtpController.to.allCountries.map((countryCode) {
              return DropdownMenuItem(
                child: new Text(
                  countryCode.toString(),
                  textAlign: TextAlign.center,
                ),
                value: countryCode.toString(),
              );
            }).toList(),
          ),
        ),
      );
    });
  }

// Widget createCountryDropdownlist1(){
//   return Obx(()=>Container (
//     width: 100,
//      decoration: BoxDecoration(
//        border: Border.all(width: 1,color: AppColors.grayColor),
//      ),
//     child: Center(
//       child: DropdownButton(
//         value: OtpController.to.selectedCountryCode.value,
//         onChanged: (newValue) {
//           // setState(() {
//           OtpController.to.selectedCountryCode.value = newValue;
//           // });
//         },
//         items: countryCodes.map((location) {
//           return DropdownMenuItem(
//             child: new Text(location,textAlign: TextAlign.center,),
//             value: location,
//           );
//         }).toList(),
//       ),
//     ),
//   ));
//
// }
//

}
