import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/core/map/MapData.dart';
import 'package:single_vendor_admin/data/model/VendorModel.dart';
import 'package:single_vendor_admin/data/repository/Repositories/VendorRepository.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstant.dart';
import 'package:single_vendor_admin/presentation/Constant/ExceptionHandle.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddAddressController extends GetxController {
  static AddAddressController to = Get.find();


  LatLng? _latLng;
  VendorRepository _vendorRepository = new VendorRepository();
  TextEditingController countryController = new TextEditingController();
  TextEditingController address_one_controller = new TextEditingController();
  TextEditingController address_two_controller = new TextEditingController();
  TextEditingController city_controller = new TextEditingController();
  TextEditingController state_controller = new TextEditingController();
  TextEditingController zip_controller = new TextEditingController();

  RxBool loading = false.obs;

  bool? isSuccess;
  RxString pickedAddress = "".obs;

  late Placemark address;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    isSuccess = false;

    getUserLocation();
  }

  getUserLocation() async {
    //call this async method from whereever you need

     var _placeMarker = await   MapData.userPosition.getCurrentLocationAsString();

    address = _placeMarker;
  }

  setDataToTextController(Placemark address) {
    pickedAddress(address.subThoroughfare!);

    countryController.text = address.country!;
    address_one_controller.text = address.administrativeArea ?? "Unknown";
    address_two_controller.text = address.subAdministrativeArea ?? "Unknown";
    city_controller.text = address.street!;
    state_controller.text = address.street!;
    zip_controller.text = address.postalCode!;
  }

  latLangToAddress(LatLng? latLng) async {
    _latLng = latLng;



    printInfo(info: "Address Info ::=> ${address}");
    setDataToTextController(address);
    update();
  }

  saveAddress() async {
    if (addAddressTextFiledValidation()) {
      loading.value = true;

      Either<dynamic, Failure> response = await (_vendorRepository.addLocation(
        _latLng!,
      ) as FutureOr<Either<dynamic, Failure>>);

      response.fold((l) {

        if (l[AppConstant.success] != null) {
          AppSnackBar.successSnackbar(
              msg: l[AppConstant.message].toString());

          loading.value = false;
          update();
        } else if (l[AppConstant.error] != null) {
          AppSnackBar.errorSnackbar(msg: l[AppConstant.error].toString());
        } else {
          isSuccess = true;

          loading.value = false;
          update();
        }
      }, (r) {
        printInfo(info: "Status Code is : : : ${r.toString()}");

        ExceptionHandle.exceptionHandle(r);

        isSuccess = false;
        loading.value = false;
        update();
      });
    } else {
      isSuccess = false;
      loading.value = false;
      update();
    }
  }

  bool addAddressTextFiledValidation() {
    if (pickedAddress.value.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Pick Location first.");
      return false;
    } else {
      return true;
    }
  }
}
