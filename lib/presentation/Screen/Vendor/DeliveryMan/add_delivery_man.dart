import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/DeliveryMan/Controller/delivery_man_controller.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

class AddDeliveryManScreen extends StatefulWidget {
  bool? isEdit;

  String? editFullName;

  String? editPhoneNUmber;

  String? editEmail;

  String? editPassword;

  AddDeliveryManScreen(
      {Key? key,
      this.isEdit = false,
      this.editEmail,
      this.editFullName,
      this.editPassword,
      this.editPhoneNUmber})
      : super(key: key);

  @override
  State<AddDeliveryManScreen> createState() => _AddDeliveryManScreenState();
}

class _AddDeliveryManScreenState extends State<AddDeliveryManScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AppDeliveryManController.to.clearAllTextFiled();
    AppDeliveryManController.to.fullNameTextEditingController.text =
        widget.editFullName ?? "";

    AppDeliveryManController.to.phoneNumberTextEditingController.text =
        widget.editPhoneNUmber ?? "";

    AppDeliveryManController.to.emailTextEditingController.text =
        widget.editEmail ?? "";

    AppDeliveryManController.to.passwordTextEditingController.text =
        widget.editPassword ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: Container(),
        backgroundColor: AppColors.orange,
        title: Text("${widget.isEdit! ? "Update" : "Add"} Delivery Man"),
        centerTitle: false,
        actions: [
          InkWell(onTap: () => Get.back(), child: Icon(Icons.close)),
          AppSpaces.spaces_width_15
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppSpaces.spaces_height_20,
                  AppTextFieldWidget(
                      controller: AppDeliveryManController
                          .to.fullNameTextEditingController,
                      hint: "Full Name"),
                  AppSpaces.spaces_height_20,
                  AppTextFieldWidget(
                      controller: AppDeliveryManController
                          .to.phoneNumberTextEditingController,
                      hint: "Phone Number",
                      textInputType: TextInputType.phone),
                  AppSpaces.spaces_height_20,
                  AppTextFieldWidget(
                      controller: AppDeliveryManController
                          .to.emailTextEditingController,
                      hint: "Email"),
                  AppSpaces.spaces_height_20,
                  AppTextFieldWidget(
                      controller: AppDeliveryManController
                          .to.passwordTextEditingController,
                      hint: "Password"),
                  AppSpaces.spaces_height_20,
                  AppSpaces.spaces_height_20,
                  Obx(
                    () => new AbsorbPointer(
                        absorbing: AppDeliveryManController.to.isLoading.value,
                        child: AppButtonWidget(
                            title: widget.isEdit! ? "Update" : "Save",
                            leadingCenter: true,
                            onTab: () async {
                              bool? _isSuccess;

                              if (widget.isEdit!) {

                                _isSuccess = await AppDeliveryManController.to
                                    .updateDeliveryMan();
                              } else {
                                _isSuccess = await AppDeliveryManController.to
                                    .saveDeliveryMan();
                              }

                              print("Is success: ${_isSuccess}");

                              if (_isSuccess!) {
                                //Get.back(result: true);

                                Navigator.pop(context, true);
                              }
                            })),
                  )
                ],
              ),
            ),
          ),
          Obx(() => AppDeliveryManController.to.isLoading.value
              ? Align(
                  alignment: Alignment.center,
                  child: AppLoading(),
                )
              : Container())
        ],
      ),
    );
  }
}
