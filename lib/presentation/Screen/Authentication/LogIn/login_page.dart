import 'package:flutter/material.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/ApiClient.dart';
import 'package:single_vendor_admin/generated/assets.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstantData.dart';
import 'package:single_vendor_admin/presentation/Routes/AppsRoutes.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/LogIn/social_log_in.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppBackgroudWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppPasswordTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppAseets.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../../../main.dart';
import '../Controller/AuthenticationController.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  late AuthenticationController _loginController;

  @override
  Widget build(BuildContext context) {
    _loginController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned.fill(child: _body(context)),
          Positioned.fill(
              child: Align(
            alignment: Alignment.center,
            child: _loading(),
          ))
        ]),
      ),
    );
  }

  _body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          // margin: EdgeInsets.all(5),
          // padding: EdgeInsets.all(20),
          child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            AppSpaces.spaces_height_10,
            AppSpaces.spaces_height_10,
            _app_logo(),
            AppSpaces.spaces_height_10,
            AppSpaces.spaces_height_10,
            AppSpaces.spaces_height_10,
            AppButtonWidget(
                evulation: 10,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                title: "Vendor",
                backgroundColor: Colors.orange,
                borderRadius: 10,
                leadingCenter: true),
            AppSpaces.spaces_height_10,
            AppSpaces.spaces_height_10,
            AppSpaces.spaces_height_10,
            _login_text(),
            AppSpaces.spaces_height_10,
            AppSpaces.spaces_height_10,
            _text_fileds(),
            AppSpaces.spaces_height_25,
            AppSpaces.spaces_height_25,
            _logInButton(),
            AppSpaces.spaces_height_10,
            AppSpaces.spaces_height_10,
            AppSpaces.spaces_height_15,
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a Member? ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  new GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.SIGN_UP);
                    },
                    child: new Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            /*  Row(
              children: [
                Image(
                  image: AssetImage(Assets.iconChatWithUs),
                  width: Get.width / 2,
                ),
                Image(
                  image: AssetImage(Assets.iconEmailUs),
                  width: Get.width / 2,
                ),
              ],
            ),
            Row(
              children: [
                Image(
                  image: AssetImage(Assets.iconCallUs),
                  width: Get.width / 2,
                ),
                Image(
                  image: AssetImage(Assets.iconTestUs),
                  width: Get.width / 2,
                ),
              ],
            ),
            AppSpaces.spaces_height_15,
            Center(
              child: Image.asset(
                Assets.iconSocialLogin,
                width: Get.width,
              ),
            )*/
          ])),
    );
  }

  Container _app_logo() {
    return Container(
      padding: EdgeInsets.all(5),
      //  height: 120,
      //width: 300,
      child: Image.asset(
        Assets.iconVendorLoginScreenLogo,
        fit: BoxFit.fill,
      ),
    );
  }

  Container _createAccount_createAccountForVendor_recoveryAccount(
      BuildContext context) {
    return Container(
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /*
          new GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.SIGN_UP);

            },
            child: new Text(
              '${language.Create_account}',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 12,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          */

          // create vendor account
          // new GestureDetector(
          //   onTap: () {
          //     Get.toNamed(AppRoutes.PHONE_NUMBER_AUTH);
          //   },
          //   child: new Text(
          //     '${language.Create_account_for_vendor}',
          //     style: TextStyle(
          //       color: Colors.deepOrange,
          //       fontSize: 12,
          //     ),
          //     textAlign: TextAlign.start,
          //   ),
          // ),

          // account recovery
          // new GestureDetector(
          //   onTap: () {
          //     Get.toNamed(AppRoutes.ACCOUNTRECOVERY);
          //   },
          //   child: new Text(
          //     '${language.Recovery_account}',
          //     style: TextStyle(
          //       color: Colors.deepOrange,
          //       fontSize: 12,
          //     ),
          //     textAlign: TextAlign.start,
          //   ),
          // ),
          AppSpaces.spaces_width_15,
        ],
      ),
    );
  }

  Widget _logInButton() {
    return Center(
      child: AppButtonWidget(
          backgroundColor: Colors.orange,
          width: 120,
          height: 40,
          leadingCenter: true,
          title: language.Login,
          onTab: () async {
            _loginController.loading.value = true;
            await _loginController.userLogin1(context);
            _loginController.loading.value = false;
          }),
    );
  }

  Container _login_text() {
    return Container(
        //width: 300,
        alignment: Alignment.topLeft,
        child: Text(
          '   ${language.Login}',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ));
  }

  _text_fileds() {
    return Column(
      children: [
        AppTextFieldWidget(
            hint: language.Enter_your_email,
            prefixIcon: Icons.perm_identity,
            controller: _loginController.userNameText,
            onSave: (value) {}),
        AppSpaces.spaces_height_10,
        AppPasswordTextFieldWidget(
            obscureText: true,
            hint: language.Enter_your_password,
            controller: _loginController.userPasswordText,
            prefixIcon: Icons.lock_outline,
            onSave: (value) {}),
      ],
    );
  }

  _loading() {
    return Obx(
        () => _loginController.loading.value ? AppLoading() : Container());
  }
}
