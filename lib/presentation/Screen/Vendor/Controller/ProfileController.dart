import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/VendorModel.dart';
import 'package:single_vendor_admin/data/repository/Repositories/DeviceTokenRepository.dart';
import 'package:single_vendor_admin/data/repository/Repositories/VendorRepository.dart';
import 'package:single_vendor_admin/data/repository/remote/Respositoris/DeviceTokenRemoteRepository.dart';

class ProfileController extends GetxController {
  static ProfileController to = Get.find();

//  static ProfileController to = Get.find(tag: "ProfileController");
  Rx<VendorModel> vendorModel = new VendorModel().obs;

  VendorRepository _vendorRepository = new VendorRepository();
  DeviceTokenRepository _deviceTokenRepository = DeviceTokenRemoteRepository();

  Future<VendorModel> getVendorProfile() async {
    Either<Response, Failure> _response = await (_vendorRepository
        .vendorProfile() as FutureOr<Either<Response<dynamic>, Failure>>);

    _response.fold((l) {
      print("Vendor Profile Response ${l.body}");

      vendorModel.value = VendorModel(
          id: l.body[0]["id"],
          fullName: l.body[0]["full_name"],
          address: l.body[0]["address"],
          email: l.body[0]["email"],
          phoneNumber: l.body[0]["phone"],
          description: l.body[0]["description"],
          shopName: l.body[0]["shop_name"],
          lat_value: l.body[0]["lat_value"],
          long_value: l.body[0]["long_value"],
          vendorImage: l.body[0]["vendor_image"] != null
              ? l.body[0]["vendor_image"]
              : "",
          openingTime: l.body[0]["opening_at"],
          closingTime: l.body[0]["closing_at"],
          updateBy: l.body[0]["updated_by"],
          rating: l.body[0]["rating"],
          isActive: l.body[0]["is_active"],
          service_provider_id: l.body[0]["service_provider_id"]);
      // print(" rashed vendor id is " +AppConstantData.vendorModel.id.toString());
    }, (r) => print("Vendor Profile Error ${r}"));

    return vendorModel.value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    printInfo(info: "ProfileController initialized...............");
  }

  saveDeviceToken(String deviceToken) {
    _deviceTokenRepository.saveDeviceToken(
        deviceToken, vendorModel.value.service_provider_id.toString());
  }
}
