import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:single_vendor_admin/core/constant/constant.dart';
import 'package:single_vendor_admin/core/map/Screen/PickCurrentLocation/Controller/PickCurrentLocationController.dart';
import 'package:single_vendor_admin/core/packages/google_map_location_picker-master/google_map_location_picker.dart';
import 'package:single_vendor_admin/presentation/Routes/AppsRoutes.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppAseets.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../Controller/AuthenticationController.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPage createState() => _AuthenticationPage();
}

class _AuthenticationPage extends State<AuthenticationPage> {
  bool valuefirst = false;
  bool? valuesecond = false;

  @override
  Widget build(BuildContext context) {

    AuthenticationController.to.loading.value = false;

    return Scaffold(
      body: Container(
        // margin: EdgeInsets.all(5),
        // height: Get.height,
        // padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _background_design(),
                _body(),
                //checkbox
                SizedBox(
                  height: 60,
                ),
              ]),
        ),
      ),
    );
  }

  Row _sign_up_title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '${language.sign_up}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget _sign_up_button() {
    return AppButtonWidget(
        title: language.sign_up,
        leadingCenter: true,
        titleColor: AppColors.white,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ));
  }

  Widget _image_upload_button() {
    return AppButtonWidget(
        horizontal_padding: 50,
        width: 200,
        title: language.upload_photo,
        borderEnable: true,
        leadingCenter: true,
        backgroundColor: AppColors.gray,
        icon: Icons.image,
        titleColor: Colors.black54);
  }

  Container trms_and_condition() {
    return Container(
        child: Column(
      children: [
        Container(
          height: 15,
          child: Row(children: <Widget>[
            Checkbox(
              value: this.valuesecond,
              onChanged: (bool? value) {
                setState(() {
                  this.valuesecond = value;
                });
              },
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              '${language.Checkbox_without_Header_and_Subtitle}  ',
              style: TextStyle(fontSize: 10.0),
            ),
          ]),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 15,
          child: Row(children: <Widget>[
            Checkbox(
              value: this.valuesecond,
              onChanged: (bool? value) {
                setState(() {
                  this.valuesecond = value;
                });
              },
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              '${language.Checkbox_without_Header_and_Subtitle}',
              style: TextStyle(fontSize: 10.0),
            ),
          ]),
        )
      ],
    ));
  }

  Container selectedImage() {
    return Container(
      width: 100,
      height: 100,
      child: Image.asset('${AppAssets.logo}'),
    );
  }

  _sign_up_text_feilds() {
    return Column(
      children: [
        AppSpaces.spaces_height_10,
        AppTextFieldWidget(
          //levelText: language.Enter_full_name,
          hint: language.Enter_full_name,
          prefixIcon: Icons.supervisor_account_outlined,
        ),
        AppSpaces.spaces_height_10,
        AppTextFieldWidget(
          hint: language.enter_your_phone_number,
          prefixIcon: Icons.person_outline_outlined,
        ),
        AppSpaces.spaces_height_10,
        AppTextFieldWidget(
            hint: language.Enter_your_email, prefixIcon: Icons.email_outlined),
        AppSpaces.spaces_height_10,
        AppTextFieldWidget(
            hint: language.Create_your_password,
            obscureText: true,
            prefixIcon: Icons.enhanced_encryption_outlined),
        AppSpaces.spaces_height_10,
        AppTextFieldWidget(
            hint: language.Create_your_password,
            obscureText: true,
            prefixIcon: Icons.enhanced_encryption_outlined),
        AppSpaces.spaces_height_10,
        AppTextFieldWidget(
            hint: language.Retype_password,
            obscureText: true,
            prefixIcon: Icons.enhanced_encryption_outlined),
        AppSpaces.spaces_height_10,
        InkWell(
          onTap: () async {
            print("The data .... ");
/*
             var location =
                await Get.toNamed(AppRoutes.PICK_UP_CURRENT_LOCATION);*/

            var _location =
                await (showLocationPicker(context, ConstantData.GOOGLE_MAP_API) as FutureOr<LocationResult>);

            PickCurrentLocationController.to.latlng(_location.latLng!);

            printInfo(info: "The location is ${_location}");
          },
          child: AppTextFieldWidget(
              enable: false,
              hint: language.location,
              prefixIcon: Icons.location_on_outlined),
        ),
        AppSpaces.spaces_height_10,
      ],
    );
  }

  _background_design() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Image.asset(AppAssets.header),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: Image.asset(
            AppAssets.runnerLogo,
            height: 100,
            width: 100,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _sign_up_title(),
          _sign_up_text_feilds(),
          _image_upload_button(),
          AppSpaces.spaces_height_10,
          selectedImage(),
          trms_and_condition(),
          AppSpaces.spaces_height_10,
          _sign_up_button(),
        ],
      ),
    );
  }
}
