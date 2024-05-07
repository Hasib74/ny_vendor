import 'package:flutter/material.dart';
import 'package:single_vendor_admin/data/model/ProductOfferModel.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddOffer/Controller/ProviderServiceOffer.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:single_vendor_admin/presentation/utils/Dimension.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class AddOffer extends StatefulWidget {
  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  // ProviderServiceOfferController _addOfferController = new ProviderServiceOfferController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(ProviderServiceOfferController(), permanent: true);

    ProviderServiceOfferController.to.offerUnitTextController.text = "TK";
    ProviderServiceOfferController.to.getVendorServiceOffer();

    // addDemoOffer();
  }

  addDemoOffer() {
    ProviderServiceOfferController.to.offerUnitTextController.text = "TK";
    ProviderServiceOfferController.to.offerNameTextController.text =
        "Combo Offer";
    ProviderServiceOfferController.to.offerCodeTextController.text =
        "Offer COde";
    ProviderServiceOfferController.to.offerDescriptionTextController.text =
        "Offer limit upto next friday";
    ProviderServiceOfferController.to.offerAmountTextController.text =
        24.toString();
  }

  @override
  Widget build(BuildContext context) {
    printInfo(
        info:
            "Offer Value ${ProviderServiceOfferController.to.vendorOffer.value}");

    return SingleChildScrollView(
      child: Obx(() => AbsorbPointer(
            absorbing: ProviderServiceOfferController.to.loading.value,
            child: Stack(
              children: [
                Column(
                  children: [
                    AppSpaces.spaces_height_25,
                    _name(),
                    AppSpaces.spaces_height_15,
                    _code(),
                    AppSpaces.spaces_height_15,
                    _amount(),
                    AppSpaces.spaces_height_15,
                    _offer_unit(),
                    AppSpaces.spaces_height_15,
                    _description(),
                    AppSpaces.spaces_height_15,
                    // _is_active() ,
                    AppSpaces.spaces_height_15,
                    _save_bar(),
                    AppSpaces.spaces_height_25,
                  ],
                ),
                _loading(),
              ],
            ),
          )),
    );
  }

  _loading() {
    return Obx(() => ProviderServiceOfferController.to.loading.value
        ? Positioned.fill(
            child: Align(
            alignment: Alignment.center,
            child: AppLoading(),
          ))
        : Container());
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
          AppButtonWidget(
              title: ProviderServiceOfferController.to.vendorOffer.value == null
                  ? language.save
                  : language.update,
              width: 80,
              leadingCenter: true,
              onTab: () {
                if (ProviderServiceOfferController.to.vendorOffer.value ==
                    null) {
                  print('calling save');
                  ProviderServiceOfferController.to.saveVendorServiceOffer();
                } else {
                  print('calling update');
                  ProviderServiceOfferController.to.updateVendorOffer();
                }
              }),
        ],
      ),
    );
  }

  Row _name() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
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
            title: language.name,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller:
                    ProviderServiceOfferController.to.offerNameTextController)),
      ],
    );
  }

  _code() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
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
            title: language.code,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller:
                    ProviderServiceOfferController.to.offerCodeTextController)),
      ],
    );
  }

  _amount() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
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
            title: language.amount,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                textInputType: TextInputType.number,
                padding: 0,
                padding_right: 16,
                controller: ProviderServiceOfferController
                    .to.offerAmountTextController)),
      ],
    );
  }

  _offer_unit() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
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
            title: language.offer_unit,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: Stack(
          children: [
            AppTextFieldWidget(
                enable: false,
                padding: 0,
                padding_right: 16,
                controller:
                    ProviderServiceOfferController.to.offerUnitTextController),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(right: 26),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: <String>["USD", "TK"].map((String e) {
                    return DropdownMenuItem<String>(
                      child: new Text(e),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (v) {
                    ProviderServiceOfferController
                        .to.offerUnitTextController.text = v!;

                    // setState(() {});
                  },
                ),
              ),
            )
          ],
        )),
      ],
    );
  }

  _description() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
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
            title: language.description,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: AppTextFieldWidget(
              textInputType: TextInputType.multiline,
              maxLines: 5,
              padding: 0,
              controller: ProviderServiceOfferController
                  .to.offerDescriptionTextController,
              height: 200),
        )),
      ],
    );
  }

  _is_active() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
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
            title: language.is_active,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: AppTextFieldWidget(
              textInputType: TextInputType.multiline,
              maxLines: 5,
              padding: 0,
              height: 200),
        )),
      ],
    );
  }
}
