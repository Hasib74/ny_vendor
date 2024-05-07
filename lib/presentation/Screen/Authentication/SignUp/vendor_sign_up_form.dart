import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:single_vendor_admin/core/map/MapData.dart';
import 'package:single_vendor_admin/main.dart';
import 'package:single_vendor_admin/presentation/Controller/AppLoading/AppLoadingController.dart';
import 'package:single_vendor_admin/presentation/Routes/AppsRoutes.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/Controller/AuthenticationController.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/SignUp/Controller/VendorSignUpController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppPasswordTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/ImageViewWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppAseets.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:single_vendor_admin/presentation/utils/Dimension.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VendorSignUpForm extends StatelessWidget {
  //getx  VendorSignUp controller initial setup

  VendorSignUpController _vendorSignUpController =
      Get.put(VendorSignUpController());

  AppLoadingController _appLoadingController = Get.find();

  //Pages variables
  bool valuefirst = true;
  bool valuesecond = true;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    AuthenticationController.to.loading.value = false;
    this.context = context;
    return Container(
      child: Obx(() => AbsorbPointer(
            absorbing: _appLoadingController.isLoading.value,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //  _user_name(),
                  AppSpaces.spaces_height_10,

                  _vendor_name(),
                  AppSpaces.spaces_height_10,
                  _shop_name(),
                  AppSpaces.spaces_height_10,
                  _location(),
                  AppSpaces.spaces_height_10,
                  _hours_of_operation(),
                  AppSpaces.spaces_height_10,
                  //  _billing_information(),
                  //  AppSpaces.spaces_height_10,
                  _insert_email(),
                  AppSpaces.spaces_height_10,
                  _password(),
                  AppSpaces.spaces_height_10,

                  _c_password(),
                  AppSpaces.spaces_height_10,
                  vendorProfileImageUI(),
                  AppSpaces.spaces_height_10,
                  trms_and_condition(),
                  AppSpaces.spaces_height_20,
                  _sign_up_button(),
                  AppSpaces.spaces_height_10,
                ],
              ),
            ),
          )),
    );
  }

  Row _password() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            horizontal_padding: 0,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            height: 45,
            width: Dimension.vendor_sign_up_text_with_icon_button_width,
            icon: Icons.lock,
            title: language.password,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppPasswordTextFieldWidget(
                padding: 0,
                hint: language.password,
                obscureText: true,
                padding_right: 16,
                controller: _vendorSignUpController.passwordController)),
      ],
    );
  }

  _c_password() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            horizontal_padding: 0,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            height: 45,
            width: Dimension.vendor_sign_up_text_with_icon_button_width,
            icon: Icons.lock,
            title: language.password,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppPasswordTextFieldWidget(
                padding: 0,
                padding_right: 16,
                obscureText: true,
                hint: language.retypePassword,
                controller: _vendorSignUpController.c_passwordController)),
      ],
    );
  }

  Row _insert_email() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            horizontal_padding: 0,
            width: Dimension.vendor_sign_up_text_with_icon_button_width,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            icon: Icons.email,
            title: language.email,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                hint: language.insert_email,
                controller: _vendorSignUpController.emailController)),
      ],
    );
  }

  _hours_of_operation() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          AppSpaces.spaces_width_10,
          AppButtonWidget(
              horizontal_padding: 0,
              width: Dimension.vendor_sign_up_text_with_icon_button_width,
              height: 45,
              textStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              icon: Icons.alarm,
              title: language.hours_of_operation,
              iconColor: Colors.white),
          AppSpaces.spaces_width_10,
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final TimeOfDay newTime = await (showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 7, minute: 15),
                    ) as FutureOr<TimeOfDay>);

                    _vendorSignUpController.openingTimeController.text =
                        newTime.format(context);
                  },
                  child: Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: AppTextFieldWidget(
                              padding: 0,
                              enable: false,
                              hint: language.openTime,
                              controller: _vendorSignUpController
                                  .openingTimeController)),
                      Container(
                        height: 48,
                        width: Dimension.open_and_close_button_width,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              topLeft: Radius.circular(5)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              language.open,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpaces.spaces_width_5,
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final TimeOfDay newTime = await (showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 7, minute: 15),
                    ) as FutureOr<TimeOfDay>);

                    _vendorSignUpController.closingTimeController.text =
                        newTime.format(context);
                  },
                  child: Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: AppTextFieldWidget(
                              padding: 0,
                              enable: false,
                              hint: language.closeTime,
                              controller: _vendorSignUpController
                                  .closingTimeController)),
                      Container(
                        height: 48,
                        width: Dimension.open_and_close_button_width + 5,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              topLeft: Radius.circular(5)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              language.close,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  _location() {
    return InkWell(
      onTap: () async {
        print("The data .... ");

        var location = await Get.toNamed(AppRoutes.PICK_UP_CURRENT_LOCATION);

        var _location = await MapData.mapFunction.latLagToString(location);

        printInfo(info: "The location is ${_location.toString()}");
        _vendorSignUpController.addressController.text = _location.toString();
      },
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpaces.spaces_width_10,
          AppButtonWidget(
              horizontal_padding: 0,
              width: Dimension.vendor_sign_up_text_with_icon_button_width,
              height: 45,
              textStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              icon: Icons.location_on,
              title: language.location,
              iconColor: Colors.white),
          AppSpaces.spaces_width_10,
          Expanded(
              child: AppTextFieldWidget(
                  enable: false,
                  padding: 0,
                  padding_right: 16,
                  hint: language.location,
                  controller: _vendorSignUpController.addressController)),
        ],
      ),
    );
  }

  Row _shop_name() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            horizontal_padding: 0,
            width: Dimension.vendor_sign_up_text_with_icon_button_width,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            icon: Icons.perm_identity,
            title: language.shop_name,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                hint: language.shop_name,
                controller: _vendorSignUpController.shopNameController)),
      ],
    );
  }

  Row _vendor_name() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            horizontal_padding: 0,
            width: Dimension.vendor_sign_up_text_with_icon_button_width,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            icon: Icons.perm_identity,
            title: language.vendor_name,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                hint: language.vendor_name,
                controller: _vendorSignUpController.vendorNameController)),
      ],
    );
  }

  vendorProfileImageUI() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        Column(
          children: [
            AppSpaces.spaces_height_15,
            AppButtonWidget(
                backgroundColor: AppColors.orange,
                leadingCenter: true,
                horizontal_padding: 0,
                width: Dimension.vendor_sign_up_text_with_icon_button_width,
                height: 45,
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                //   icon: Icons.location_on,
                title: language.photo,
                iconColor: Colors.white),
          ],
        ),
        AppSpaces.spaces_width_10,
        Expanded(
          child: Column(
            children: [
              AppSpaces.spaces_height_15,
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: AppButtonWidget(
                    backgroundColor: AppColors.text_fileld_color,
                    leadingCenter: true,
                    horizontal_padding: 0,
                    width: Dimension.vendor_sign_up_text_with_icon_button_width,
                    height: 45,
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    //   icon: Icons.location_on,
                    title: language.upload,
                    onTab: () {
                      showProductImageSelectSource();
                    },
                    iconColor: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: GetBuilder<VendorSignUpController>(
            builder: (_) {
              print("Path is ${_.vendorProfileImage}");

              return Container(
                child: _.vendorProfileImage == null
                    ? ImageViewWidget(imageUrl: AppAssets.demo_profile_image)
                    : ImageViewWidget(
                        file: File(_.vendorProfileImage!.path),
                        imageUrl: '',
                      ),
              );
            },
          ),
        ),
        AppSpaces.spaces_width_15,
      ],
    );
  }

  Container trms_and_condition() {
    return Container(
        child: Column(
      children: [
        AppSpaces.spaces_width_10,
        Container(
          height: 15,
          child: Row(children: <Widget>[
            Obx(() {
              return Checkbox(
                activeColor: AppColors.orange,
                value: _vendorSignUpController.valuefirst.value,
                onChanged: (bool? value) {
                  _vendorSignUpController.valuefirst.value = !(this.valuefirst);
                  this.valuefirst = _vendorSignUpController.valuefirst.value;
                  // print('hello checkbox $value 1 ${this.valuefirst}');
                  //  _vendorSignUpController.updateCheckBox();
                },
              );
            }),
            InkWell(
              onTap: () {
                showTermsndCondition(context);
              },
              child: Text(
                '${language.terms_conditions}  ',
                style: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.orange,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ),

        /*
        Container(
          height: 10,
          child: Row(children: <Widget>[
            Checkbox(
              value: this.valuesecond,
              onChanged: (bool value) {
                this.valuesecond =  !this.valuesecond;
                print('hello checkbox 2 $valuesecond');
                _vendorSignUpController.updateCheckBox();
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
        */
      ],
    ));
  }

  Widget _sign_up_button() {
    return AppButtonWidget(
      leadingCenter: true,
      onTab: () async {
        //Navigator.pushNamed(context, AppRoutes.ADD_ITEMS
        //     _vendorSignUpController.setLoading(isLoading: true);

        _appLoadingController.isLoading.value = true;

        if (await _vendorSignUpController.vendorSignUp()) {
          Get.offAllNamed(AppRoutes.VENDOR_HOME_PAGE);
        }

        _appLoadingController.isLoading.value = false;
      },
      title: language.sign_up,
    );
  }

  _billing_information() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          AppButtonWidget(
              horizontal_padding: 0,
              width: Dimension.vendor_sign_up_text_with_icon_button_width,
              height: 45,
              textStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              icon: Icons.alarm,
              title: language.hours_of_operation,
              iconColor: Colors.white),
          Expanded(
            child: Container(
              height: 48,
              width: Dimension.open_and_close_button_width,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    language.add_paypal,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppSpaces.spaces_width_5,
          Expanded(
              child: Container(
            height: 48,
            width: Dimension.open_and_close_button_width,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  language.master_or_visa_card,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  _user_name() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            horizontal_padding: 0,
            width: Dimension.vendor_sign_up_text_with_icon_button_width,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            icon: Icons.perm_identity,
            title: language.user_name,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                hint: language.user_name,
                controller: _vendorSignUpController.userNameController)),
      ],
    );
  }

  final imagePicker = ImagePicker();

  Future openPhoneCameraOrGallery(bool isCamera) async {
    // final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    XFile? pickedFile;
    if (isCamera) {
      pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    }
    Navigator.pop(context);
    if (pickedFile != null) {
      _vendorSignUpController.vendorProfileImage = File(pickedFile.path);
      _vendorSignUpController.setVendorProfileImage();
      // Get.back();
      print('photo ok');
    } else {
      print('No image selected.');
    }
  }

  Future<void> showProductImageSelectSource() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Select Product Image ')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[],
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Icon(Icons.photo_album), // Text('Open Gallery'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.deepOrange,
                  onSurface: Colors.grey,
                  shadowColor: Colors.red,
                  elevation: 5,
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),
                onPressed: () {
                  openPhoneCameraOrGallery(false);
                },
              ),
            ),
            SizedBox(height: 7),
            Center(
              child: TextButton(
                child: Icon(Icons.camera_alt), // Text('Open Camera'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.deepOrange,
                  onSurface: Colors.grey,
                  shadowColor: Colors.red,
                  elevation: 5,
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),
                onPressed: () {
                  openPhoneCameraOrGallery(true);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void showTermsndCondition(BuildContext context) {
    // set up the buttons
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Terms & Condition"),
      content: Text("Terms & Condition goes here!"),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
