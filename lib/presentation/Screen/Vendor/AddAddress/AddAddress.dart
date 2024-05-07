import 'dart:async';

import 'package:flutter/material.dart';
import 'package:single_vendor_admin/core/constant/constant.dart';
import 'package:single_vendor_admin/core/map/MapData.dart';
import 'package:single_vendor_admin/core/map/Screen/PickCurrentLocation/Controller/PickCurrentLocationController.dart';
import 'package:single_vendor_admin/core/map/Screen/PickCurrentLocation/PickCurrentLocation.dart';
import 'package:single_vendor_admin/core/packages/google_map_location_picker-master/src/google_map_location_picker.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddAddress/Controller/AddAddressController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/EditProfile/EditProfileController/EditProfileController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoadingWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppToggle/AppMapWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:single_vendor_admin/presentation/utils/Dimension.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/packages/google_map_location_picker-master/src/model/location_result.dart';
import '../../../../main.dart';

late AddAddressController _addAddressController;

class AddAddress extends StatelessWidget {
  static final CameraPosition _initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    Get.put(AddAddressController());

    _addAddressController = Get.find();

    printInfo(info: "  ${_addAddressController.countryController.value.text}");

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              AppSpaces.spaces_height_25,
              Obx(() {
                print(">>>>>>> ${AddAddressController.to.pickedAddress.value}");
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.gray,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                          child: Text(
                        _show_location(AddAddressController
                                .to.pickedAddress.value.isEmpty
                            ? "Please add location by clicking location button."
                            : AddAddressController.to.pickedAddress.value)!,
                        style: Get.textTheme.headline6,
                        textAlign: TextAlign.center,
                      )),
                      height: 120,
                      width: double.infinity,
                    ),
                  ),
                );
              })

              /*       _country(),
              AppSpaces.spaces_height_15,
              _address_line_one(),
              AppSpaces.spaces_height_15,
              _address_line_two(),
              AppSpaces.spaces_height_15,
              _city(),
              AppSpaces.spaces_height_15,
              _state(),
              AppSpaces.spaces_height_15,
              _zip(),
              AppSpaces.spaces_height_15*/
              ,
              _pick_location(context),
              _save_bar(),
            ],
          ),
        ),
        _loading(),
      ],
    );
  }

  _loading() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: Obx(() {
          if (_addAddressController.loading.value) {
            return AppLoading();
          } else {
            return Container();
          }
        }),
      ),
    );
  }

  _save_bar() {
    return InkWell(
      //onTap: () => _addAddressController.saveAddress(),
      child: Padding(
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
            InkWell(
              onTap: () => _addAddressController.saveAddress(),
              child: AppButtonWidget(
                  title: language.save, width: 80, leadingCenter: true),
            )
          ],
        ),
      ),
    );
  }

  Row _city() {
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.city,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller: _addAddressController.city_controller)),
      ],
    );
  }

  _address_line_one() {
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.address_line_one,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller: _addAddressController.address_one_controller)),
      ],
    );
  }

  _address_line_two() {
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.address_line_two,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller: _addAddressController.address_two_controller)),
      ],
    );
  }

  _country() {
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.country,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller: _addAddressController.countryController)),
      ],
    );
  }

  _state() {
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.state,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller: _addAddressController.state_controller)),
      ],
    );
  }

  _zip() {
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.zip,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(child: GetBuilder<AddAddressController>(
          builder: (_addAddressController) {
            return AppTextFieldWidget(
                padding: 0,
                padding_right: 16,
                controller: _addAddressController.zip_controller);
          },
        )),
      ],
    );
  }

  _pick_location(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        FloatingActionButton(
          onPressed: () => showPlacePicker(context),
          backgroundColor: AppColors.orange,
          child: Icon(
            Icons.location_on,
            color: Colors.white,
          ),
        ),
        AppSpaces.spaces_width_25,
      ],
    );
  }

  void showPlacePicker(BuildContext context) async {
    //  LatLng _latlng = await Get.to(PickCurrentLocationScreen());

    var _location =
        await (showLocationPicker(context, ConstantData.GOOGLE_MAP_API) as FutureOr<LocationResult>);

    PickCurrentLocationController.to.latlng(_location.latLng!);

    _addAddressController.latLangToAddress(_location.latLng);
  }

  String? _show_location(String location) {
    String? _location;

    if (location != null) {
      _location = location;
    } else if (ProfileController.to.vendorModel.value.lat_value == null) {
      MapData.mapFunction
          .latLagToString(LatLng(
              double.parse(ProfileController.to.vendorModel.value.lat_value!),
              double.parse(ProfileController.to.vendorModel.value.long_value!)))
          .then((value) {
        _location = value.toString();
      });
    } else {
      _location = "Please add location by clicking location button.";
    }

    print("Location Value ============> ${_location}");

    return _location;
  }
}
