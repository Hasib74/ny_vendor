import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/Controller/AuthenticationController.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/SignUp/Controller/VendorSignUpController.dart';
import 'dart:io';



import '../../../Widgets/AppButtonWidget.dart';
import '../../../Widgets/AppLoading.dart';
import '../../../Widgets/AppPasswordTextFieldWidget.dart';
import '../../../Widgets/AppTextFieldWidget.dart';
import '../../../Widgets/ImageViewWidget.dart';
import '../../../utils/AppColors.dart';
import '../../../utils/AppSpaces.dart';
import '../Controller/sign_up_controller.dart';

class SignupForm extends StatelessWidget {
  //getx  VendorSignUp controller initial setup

  SignupController _signupController = Get.put(SignupController());

  String? mobileNo;

  //Pages variables
  bool valuefirst = false;
  bool valuesecond = false;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;


    // SignupController.to.phoneController.text = Get.arguments.toString();

  //  PickCurrentLocationController.to.getCurrentLocation();

    // mobileNo = Get.arguments.toString();
    //  print('usern mobile no '+mobileNo);

    Future.delayed(Duration.zero).then((value) => AuthenticationController.to.loading.value = false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        child: Stack(
          children: [
            _body(),
            _loading(),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppSpaces.spaces_height_25,
          _name(),
          AppSpaces.spaces_height_10,
          _user_name(),
          AppSpaces.spaces_height_10,
          _phone_number(),
          AppSpaces.spaces_height_10,
          _location(),
          AppSpaces.spaces_height_10,
          _insert_email(),
          AppSpaces.spaces_height_10,
          _password(),
          AppSpaces.spaces_height_10,
          _c_password(),
          AppSpaces.spaces_height_10,
          // profileNIDRow('NID',context),
          //_image_upload_button(),
          AppSpaces.spaces_height_10,
        ///  selectedImage(),
          AppSpaces.spaces_height_10,
       //   _nid_image_upload_button(),
          AppSpaces.spaces_height_10,
          //selectedNIDImage(),
          AppSpaces.spaces_height_10,
          trms_and_condition(),
          AppSpaces.spaces_height_20,
          _sign_up_button(),
          AppSpaces.spaces_height_10,
        ],
      ),
    );
  }

  Row _name() {
    return Row(
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            horizontal_padding: 0,
            width: 120,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            icon: Icons.people,
            title: "Name:",
            backgroundColor: Colors.deepOrangeAccent,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller: SignupController.to.nameController)),
      ],
    );
  }

  _user_name() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            horizontal_padding: 0,
            width: 120,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            icon: Icons.perm_identity,
            title: 'User-name',
            backgroundColor: Colors.deepOrangeAccent,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller: SignupController.to.usernameController)),
      ],
    );
  }

  Row _phone_number() {
    return Row(
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: Colors.deepOrangeAccent,
            horizontal_padding: 0,
            width: 120,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            icon: Icons.phone,
            title: 'Phone',
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                //  levelText: mobileNo,

                controller: SignupController.to.phoneController)),
      ],
    );
  }

  _location() {
    return GetBuilder<SignupController>(
        builder: (_) => Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpaces.spaces_width_10,
            AppButtonWidget(
                backgroundColor: Colors.deepOrangeAccent,
                horizontal_padding: 0,
                width: 120,
                height: 45,
                textStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                icon: Icons.location_on,
                title: 'Location',
                iconColor: Colors.white),
            AppSpaces.spaces_width_10,
            Expanded(
                child: AppTextFieldWidget(
                    padding: 0,
                    padding_right: 16,
                    controller: _signupController.addressController)),
          ],
        ));
  }

  Row _insert_email() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: Colors.deepOrangeAccent,
            horizontal_padding: 0,
            width: 120,
            height: 45,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            icon: Icons.email,
            title: "Email",
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller: SignupController.to.emailController)),
      ],
    );
  }

  Row _password() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: Colors.deepOrangeAccent,
            horizontal_padding: 0,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            height: 45,
            width: 120,
            icon: Icons.lock,
            title: 'Password',
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppPasswordTextFieldWidget(
                padding: 0,
                padding_right: 16,
                obscureText: true,
                controller: SignupController.to.passwordController)),
      ],
    );
  }

  _c_password() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: Colors.deepOrangeAccent,
            horizontal_padding: 0,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            height: 45,
            width: 120,
            icon: Icons.lock,
            title: "C password",
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppPasswordTextFieldWidget(
                padding: 0,
                padding_right: 16,
                obscureText: true,
                controller: SignupController.to.confirmPasswordController)),
      ],
    );
  }

  Container trms_and_condition() {
    return Container(child: GetBuilder<SignupController>(
      builder: (_) {
        return Column(
          children: [
            AppSpaces.spaces_width_10,
            Container(
              height: 10,
              child: Row(children: <Widget>[
                Checkbox(
                  value: SignupController.to.isAgreePrivacyPolicy.value,
                  onChanged: (bool? value) {
                    print('click on Me ');

                    SignupController.to.setPrivacyPolicyAgreement(
                        !SignupController.to.isAgreePrivacyPolicy.value);
                    print(
                        'click on Me now ${SignupController.to.isAgreePrivacyPolicy.value}');
                  },
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  'I accept the terms & condition',
                  style: TextStyle(fontSize: 10.0),
                ),
              ]),
            ),
            SizedBox(
              height: 15,
            ),
            // Container(
            //   height: 10,
            //   child: Row(children: <Widget>[
            //     Checkbox(
            //       value: this.valuesecond,
            //       onChanged: (bool value) {},
            //     ),
            //     SizedBox(
            //       width: 2,
            //     ),
            //     Text(
            //       'Send notification when new items are available',
            //       style: TextStyle(fontSize: 10.0),
            //     ),
            //   ]),
            // )
          ],
        );
      },
    ));
  }

  Widget _sign_up_button() {
    return AppButtonWidget(
      backgroundColor: Colors.deepOrangeAccent,
      leadingCenter: true,
      onTab: () async {
        await SignupController.to.SignUp(context);

        Navigator.pop(context);
      },
      title: 'Sign Up',
    );
  }

  Widget _image_upload_button() {
    return AppButtonWidget(
        horizontal_padding: 50,
        title: 'Pick Profile Image',
        borderEnable: true,
        backgroundColor: AppColors.gray,
        icon: Icons.image,
        titleColor: Colors.black54,
        onTab: () {
          SignupController.to.isloadingCameraorGalleryFor = 1;
          showProductImageSelectSource(context);
        });
  }

  Widget _nid_image_upload_button() {
    return AppButtonWidget(
        horizontal_padding: 50,
        title: 'Pick Your NID',
        borderEnable: true,
        backgroundColor: AppColors.gray,
        icon: Icons.image,
        titleColor: Colors.black54,
        onTab: () {
          SignupController.to.isloadingCameraorGalleryFor = 2;
          showProductImageSelectSource(context);
        });
  }

  Container selectedImage() {
    return Container(
      width: 250,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.orange),
      ),
      child: GetBuilder<SignupController>(
        builder: (_) {
          return ImageViewWidget(
            imageUrl: '',
            file: _.profilePhoto,
            borderEnable: true,
          );
        },
      ),
    );
  }

  Container selectedNIDImage() {
    return Container(
      width: 250,
      height: 150,
      decoration: BoxDecoration(border: Border.all(color: AppColors.orange)),
      child: GetBuilder<SignupController>(
        builder: (_) {
          return ImageViewWidget(
            imageUrl: '',
            file: _.nidCardImageFile,
            borderEnable: true,
          );
        },
      ),
    );
  }

  Future<void> showProductImageSelectSource(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Choose a Image')),
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
                  openPhoneCameraOrGallery(false, context);
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
                  openPhoneCameraOrGallery(true, context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future openPhoneCameraOrGallery(bool isCamera, BuildContext context) async {
    File image;
    if (isCamera) {
      var _pickedImage = await (ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50));
      image = File(_pickedImage!.path);
    } else {
      var _pickedImage = await (ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50));
      image = File(_pickedImage!.path);
    }

    Get.back();
    if (image != null) {
      _signupController.setNidCardImageFile(image);
      print('photo ok');
    } else {
      print('No image selected.');
    }
  }

  _loading() {
    return Obx(() => Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child:
          SignupController.to.isLoading.value ? AppLoading() : Container(),
        )));
  }
}
