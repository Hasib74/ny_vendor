import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/EditProfile/EditProfileController/EditProfileController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HomePage/Controller/VendorHomePageController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppPasswordTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppToggle/AppToggleButton.dart';
import 'package:single_vendor_admin/presentation/Widgets/ImageViewWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppAseets.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:single_vendor_admin/presentation/utils/Dimension.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../main.dart';

VendorHomePageController _vendorHomePageController = Get.find();

class EditProfile extends StatelessWidget {
  //getx  VendorSignUp controller initial setup

  //Pages variables
  bool valuefirst = false;
  bool valuesecond = false;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    Get.put(
      EditProfileController(),
    );
    EditProfileController.to.intialData();

    this.context = context;
    return Container(
      child: Obx(() => AbsorbPointer(
            absorbing: EditProfileController.to.loading.value,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: _body(),
                ),
                _loading(),
              ],
            ),
          )),
    );
  }

  Column _body() {
    return Column(
      children: [
        AppSpaces.spaces_height_25,

        _image_pick_and_view(),
        AppSpaces.spaces_height_25,
        //    _user_name(),
        //  AppSpaces.spaces_height_10,
        _vendor_name(),
        AppSpaces.spaces_height_10,
        _shop_name(),
        AppSpaces.spaces_height_10,
        // _location(),
        AppSpaces.spaces_height_10,
        //    _hours_of_operation(),
        // AppSpaces.spaces_height_10,
        //  _billing_information(),
        //  AppSpaces.spaces_height_10,
        _insert_email(),
        AppSpaces.spaces_height_10,
        //_password(),
        AppSpaces.spaces_height_10,

        // _current_status(),
        //  AppSpaces.spaces_height_10,

        // AppSpaces.spaces_height_25,

        _update_button(),
      ],
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
            // icon: Icons.lock,
            leadingCenter: true,
            title: language.password,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppPasswordTextFieldWidget(
          controller: EditProfileController.to.passwordController,
          padding: 0,
          enable: false,
          obscureText: true,
          padding_right: 16,
        )),
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
            leadingCenter: true,
            // icon: Icons.email,
            title: language.email,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
          controller: EditProfileController.to.emailController,
          padding: 0,
          enable: false,
          padding_right: 16,
        )),
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
              leadingCenter: true,
              //icon: Icons.alarm,
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

                    EditProfileController.to.openingTimeController.text =
                        newTime.format(context);
                  },
                  child: Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: AppTextFieldWidget(
                            enable: false,
                            textStyle: const TextStyle(fontSize: 14),
                            controller:
                                EditProfileController.to.openingTimeController,
                            padding: 0,
                          )),
                      Container(
                        height: 48,
                        width: Dimension.open_and_close_button_width,
                        decoration: BoxDecoration(
                          color: AppColors.orange,
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

                    EditProfileController.to.closingTimeController.text =
                        newTime.format(context);
                  },
                  child: Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: AppTextFieldWidget(
                            enable: false,
                            controller:
                                EditProfileController.to.closingTimeController,
                            padding: 0,
                          )),
                      Container(
                        height: 48,
                        width: Dimension.open_and_close_button_width + 5,
                        decoration: BoxDecoration(
                          color: AppColors.orange,
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

  Row _location() {
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
            // icon: Icons.location_on,
            title: language.location,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
          padding: 0,
          padding_right: 16,
        )),
      ],
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
            leadingCenter: true,
            //icon: Icons.perm_identity,
            title: language.shop_name,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
          controller: EditProfileController.to.shopNameController,
          padding: 0,
          padding_right: 16,
        )),
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
            leadingCenter: true,
            //   icon: Icons.perm_identity,
            title: language.vendor_name,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
          controller: EditProfileController.to.vendorNameController,
          padding: 0,
          padding_right: 16,
        )),
      ],
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

  Container trms_and_condition() {
    return Container(
        child: Column(
      children: [
        AppSpaces.spaces_width_10,
        Container(
          height: 10,
          child: Row(children: <Widget>[
            Checkbox(
              value: this.valuesecond,
              onChanged: (bool? value) {},
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
          height: 10,
          child: Row(children: <Widget>[
            Checkbox(
              value: this.valuesecond,
              onChanged: (bool? value) {},
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
            child: AppTextFieldWidget(
          padding: 0,
          padding_right: 16,
        )),
      ],
    );
  }

  _user_name() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            leadingCenter: true,
            horizontal_padding: 0,
            width: Dimension.vendor_sign_up_text_with_icon_button_width,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            //  icon: Icons.perm_identity,

            title: language.user_name,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
          controller: EditProfileController.to.userNameController,
          padding: 0,
          padding_right: 16,
        )),
      ],
    );
  }

  _current_status() {
    return Row(
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
            leadingCenter: true,
            // icon: Icons.perm_identity,
            title: language.active_status,
            iconColor: Colors.white),
        AppSpaces.spaces_width_25,
        AppToggleButton(
          isActive: (bool isActive) {
            //  print(isActive);

            EditProfileController.to.setIsActiveStatus(isActive);
          },
        ),
      ],
    );
  }

  Widget _image_pick_and_view() {
    return Stack(
      children: [
        Obx(() => InkWell(
              onTap: () async {
                XFile? pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                EditProfileController.to.setFile(File(pickedFile!.path));
              },
              child: ImageViewWidget(
                file: EditProfileController.to.file?.value,
                borderEnable: true,
                imageSize: 150,
                imageType: ImageType.RING,
                imageUrl:
                    ProfileController.to.vendorModel.value.vendorImage == null
                        ? AppAssets.demo_profile_image
                        : URL.host_url +
                            ProfileController.to.vendorModel.value.vendorImage!,
              ),
            )),
        Positioned(
          right: 10,
          bottom: 15.0,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                shape: BoxShape.circle),
            child: Icon(
              Icons.camera_alt,
              size: 10,
            ),
          ),
        )
      ],
    );
  }

  _update_button() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppButtonWidget(
          // horizontal_padding: 0,

          onTab: () async {
            EditProfileController.to.loading(true);

            print("Truuuuuuuuuuuuuuuuuuuue");

            await EditProfileController.to.vendorUpdateProfile();

            await ProfileController.to.getVendorProfile();

            EditProfileController.to.loading(false);
          },
          textStyle: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          height: 45,
          // icon: Icons.lock,
          leadingCenter: true,
          title: language.update,
          iconColor: Colors.white),
    );
  }

  _loading() {
    return Align(
      alignment: Alignment.center,
      child: Obx(() {
        printInfo(
          info: "Loading............${EditProfileController.to.loading.value}",
        );

        if (EditProfileController.to.loading.value) {
          return AppLoading();
        } else {
          return Container();
        }
      }),
    );
  }
}
