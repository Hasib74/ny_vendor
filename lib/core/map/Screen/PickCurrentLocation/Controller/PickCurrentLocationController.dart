import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../MapData.dart';

class PickCurrentLocationController extends GetxController {
  RxBool loading = false.obs;

  Rx<LatLng> latlng = LatLng(0.0, 0.0).obs;

  static PickCurrentLocationController to = Get.find();

  Completer<GoogleMapController> pickLocationGoogleMapcontroller = Completer();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void getCurrentLocation() async {
    loading = true.obs;

    MapData.userPosition.determinePosition().then((value) async {
      print("Current Location ${LatLng(value.latitude!, value.longitude!)}");
      latlng.value = LatLng(value.latitude!, value.longitude!);
      print(
          "Current Location 2 ${LatLng(latlng.value.latitude, latlng.value.longitude)}");

      loading = false.obs;

      final GoogleMapController controller =
          await pickLocationGoogleMapcontroller.future;
      controller.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(target: latlng.value ,zoom: 20.0)));
    });
  }
}
