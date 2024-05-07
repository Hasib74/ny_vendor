import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:single_vendor_admin/presentation/Controller/AppLoading/AppLoadingController.dart';
import 'package:single_vendor_admin/presentation/utils/AppAseets.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:get/get.dart';

import 'AppLoading.dart';

class AppBackgroundWidget extends StatelessWidget {
  Widget? child;

  AppBackgroundWidget({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                //  _header_logo(),
                // AppSpaces.spaces_width_10,
                _app_logo(),
                Expanded(child: child!),
              ],
            ),
            Obx(() => AppLoadingController.to.isLoading.value
                ? _loading()
                : Container())
          ],
        ),
      ),
    );
  }

  Container _app_logo() {
    return Container(
      padding: EdgeInsets.all(5),
      height: 120,
      width: 300,
      child: Image.asset(AppAssets.logo),
    );
  }

  Container _header_logo() {
    return Container(
      width: double.infinity,
      child: Image.asset(AppAssets.header),
    );
  }

  _loading() {
    return Align(
        alignment: Alignment.center, child: AppLoading());
  }
}
