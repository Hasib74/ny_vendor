import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

class DirectionalApi {
  distanceBtw({LatLng? lt1, LatLng? lt2}) {
    var distance = _getDistanceFromLatLonInKm(
        lat1: lt1?.latitude,
        lat2: lt2?.latitude,
        lon1: lt1?.longitude,
        lon2: lt2?.longitude);
    print("Distance btween two location is  ${distance}");

    return distance ;
/*    var url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=Disneyland&destination=Universal+Studios+Hollywood&key=${MapData.googleMapToken}";*/
  }

  _getDistanceFromLatLonInKm(
      {required lat1, required lon1, required lat2, required lon2}) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(lat1)) *
            math.cos(deg2rad(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  deg2rad(deg) {
    return deg * (math.pi / 180);
  }
}
