import 'dart:math';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:math' as math;

import 'package:vector_math/vector_math.dart';

class MapFunction {
  Future<String> latLagToString(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    // final coordinates = new Ge;
    // var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = placemarks[0];
    // print("${first} , ${first.addressLine}");

    return "${first.subAdministrativeArea},${first.street},${first.subLocality},${first.locality},${first.country}"; //"${first.featureName} , ${first.addressLine}";
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    Uint8List _list =
        (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();

    print("Image of : ${path} and the unit8list is : ${_list}");

    return _list;
  }

  static LatLngBounds getBounds(List<Marker> markers) {
    var lngs = markers.map<double>((m) => m.position.longitude).toList();
    var lats = markers.map<double>((m) => m.position.latitude).toList();

    double topMost = lngs.reduce(max);
    double leftMost = lats.reduce(min);
    double rightMost = lats.reduce(max);
    double bottomMost = lngs.reduce(min);

    LatLngBounds bounds = LatLngBounds(
      northeast: LatLng(rightMost, topMost),
      southwest: LatLng(leftMost, bottomMost),
    );

    return bounds;
  }

  double getOffsetFromNorth(double currentLatitude, double currentLongitude,
      double targetLatitude, double targetLongitude) {
    var la_rad = radians(currentLatitude);
    var lo_rad = radians(currentLongitude);

    var de_la = radians(targetLatitude);
    var de_lo = radians(targetLongitude);

    var toDegrees = degrees(atan(sin(de_lo - lo_rad) /
        ((cos(la_rad) * tan(de_la)) - (sin(la_rad) * cos(de_lo - lo_rad)))));
    if (la_rad > de_la) {
      if ((lo_rad > de_lo || lo_rad < radians(-180.0) + de_lo) &&
          toDegrees > 0.0 &&
          toDegrees <= 90.0) {
        toDegrees += 180.0;
      } else if (lo_rad <= de_lo &&
          lo_rad >= radians(-180.0) + de_lo &&
          toDegrees > -90.0 &&
          toDegrees < 0.0) {
        toDegrees += 180.0;
      }
    }
    if (la_rad < de_la) {
      if ((lo_rad > de_lo || lo_rad < radians(-180.0) + de_lo) &&
          toDegrees > 0.0 &&
          toDegrees < 90.0) {
        toDegrees += 180.0;
      }
      if (lo_rad <= de_lo &&
          lo_rad >= radians(-180.0) + de_lo &&
          toDegrees > -90.0 &&
          toDegrees <= 0.0) {
        toDegrees += 180.0;
      }
    }
    return toDegrees;
  }
}
