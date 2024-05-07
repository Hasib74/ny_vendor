import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/*
class AppMapWidget extends StatelessWidget {
  static final CameraPosition _initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: GoogleMap(
          // all the other arguments

          initialCameraPosition: _initialLocation,
          onTap: (latLng) {
            print('${latLng.latitude}, ${latLng.longitude}');

            Get.back(result: LatLng(latLng.latitude, latLng.longitude));
          }),
    );
  }
}
*/
