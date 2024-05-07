import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/CredentialInformation/Controller/CredentialChnagedPasswordController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/CredentialInformation/Controller/CredentialInformationController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppPasswordTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

import '../../../../main.dart';

class CredentialInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    CredentialInformationController.to.getBankInfo();

    return SingleChildScrollView(
      child: Column(
        children: [
          AppSpaces.spaces_height_25,
          BankSectionTitle(),
          AppSpaces.spaces_height_25,
          _bankHolder(),
          AppSpaces.spaces_height_10,
          _account_number(),
          AppSpaces.spaces_height_10,
          _bank_name(),
          AppSpaces.spaces_height_10,
          _save_bar(),
          AppSpaces.spaces_height_25,
          _loading(),
          AppSpaces.spaces_height_10,
          PasswordSectionTitle(),
          AppSpaces.spaces_height_10,
          _loading_changedPassword(),
          AppSpaces.spaces_height_25,
          _current_password(),
          AppSpaces.spaces_height_10,
          _new_password(),
          AppSpaces.spaces_height_10,
          _re_type_password(),
          _update_bar(),
        ],
      ),
    );
  }

  Widget BankSectionTitle() {
    return AppButtonWidget(
        backgroundColor: AppColors.orange,
        leadingCenter: true,
        horizontal_padding: 16,
        width: Get.width,
        height: 45,
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        //   icon: Icons.location_on,
        title: language.bank_section_title,
        iconColor: Colors.white);
  }

  Row _bankHolder() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
            leadingCenter: true,
            horizontal_padding: 0,
            width: 140,
            height: 45,
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.account_name,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller:
                    CredentialInformationController.to.bankHolderController)),
      ],
    );
  }

  Row _account_number() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
            leadingCenter: true,
            horizontal_padding: 0,
            width: 140,
            height: 45,
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.account_number,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                textInputType: TextInputType.number,
                padding: 0,
                padding_right: 16,
                controller: CredentialInformationController
                    .to.accountNumberController)),
      ],
    );
  }

  _bank_name() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
            leadingCenter: true,
            horizontal_padding: 0,
            width: 140,
            height: 45,
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.bank_name,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller:
                    CredentialInformationController.to.bankNameController)),
      ],
    );
  }

  _save_bar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          AppSpaces.spaces_width_25,
          CredentialInformationController.to.bankInfo.value == null
              ? AppButtonWidget(
                  title: language.save,
                  width: 80,
                  leadingCenter: true,
                  onTab: () async {
                    CredentialInformationController.to.createBankInfo();
                  },
                )
              : AppButtonWidget(
                  title: language.update,
                  width: 80,
                  leadingCenter: true,
                  onTab: () async {
                    CredentialInformationController.to.updateBankInfo();
                  },
                )
        ],
      ),
    );
  }

  Widget PasswordSectionTitle() {
    return AppButtonWidget(
        backgroundColor: AppColors.orange,
        leadingCenter: true,
        horizontal_padding: 16,
        width: Get.width,
        height: 45,
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        //   icon: Icons.location_on,
        title: language.password_section_title,
        iconColor: Colors.white);
  }

  _current_password() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
            leadingCenter: true,
            horizontal_padding: 0,
            width: 160,
            height: 45,
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.current_password,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppPasswordTextFieldWidget(
                obscureText: true,
                controller: CredentialChangedPasswordController
                    .to.currentPasswordController,
                padding: 0,
                padding_right: 16)),
      ],
    );
  }

  _new_password() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
            leadingCenter: true,
            horizontal_padding: 0,
            width: 160,
            height: 45,
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.new_password,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppPasswordTextFieldWidget(
          padding: 0,
          padding_right: 16,
          obscureText: true,
          controller: CredentialChangedPasswordController
              .to.newPasswordPasswordController,
        )),
      ],
    );
  }

  _re_type_password() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
            leadingCenter: true,
            horizontal_padding: 0,
            width: 160,
            height: 45,
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.re_type_password,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppPasswordTextFieldWidget(
          padding: 0,
          padding_right: 16,
          obscureText: true,
          controller:
              CredentialChangedPasswordController.to.confirmPasswordController,
        )),
      ],
    );
  }

  _update_bar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          AppSpaces.spaces_width_25,
          AppButtonWidget(
              onTab: () async {
                CredentialChangedPasswordController.to.updatePassword();
              },
              title: language.update,
              width: 100,
              font_size: 18,
              leadingCenter: true)
        ],
      ),
    );
  }

  _loading() {
    return Obx(() => CredentialInformationController.to.loading.value
        ? Align(
            alignment: Alignment.center,
            child: AppLoading(),
          )
        : Container());
  }

  _loading_changedPassword() {
    return Obx(() => CredentialChangedPasswordController.to.loading.value
        ? Align(
            alignment: Alignment.center,
            child: AppLoading(),
          )
        : Container());
  }
}
