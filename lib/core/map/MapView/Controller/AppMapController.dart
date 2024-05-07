import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../Data/Firebase/DataSource/FirebaseKey.dart';
import '../../../../Presentation/utils/AppColors.dart';
import '../../MapData.dart';

class AppMapController extends GetxController {
  static AppMapController to = Get.find();

  Rx<Position> position =  Position(longitude: 0.0 , latitude: 0.0 ,accuracy: 0.0,altitude: 0.0, timestamp: null, heading: 0.0, speed: 0.0, speedAccuracy: 0.0).obs;

  RxSet<Marker> markers = <Marker>{}.obs;

  // RxSet<Polyline> polyLine = <Polyline>{}.obs;

  // List<LatLng> polylineCoordinates = [];

  Rx<LatLng> currentLocation = new LatLng(0, 0).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _checkPermission();

    //  getCurrentLocation();
  }

  _checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('', 'Location Permission Denied');
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future getCurrentLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled == true) {
      position.value = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      currentLocation.value =
          LatLng(position.value.latitude, position.value.longitude);
    }

    return position.value;
  }

  // Future<PolylineResult> getPolylinePoints(
  //     LatLng source, LatLng destination) async {
  //   PolylineResult result;
  //
  //   try {
  //     AppMapController.to.polyLine.clear();
  //
  //     printInfo(info: "Source :: ${source}  Destination :: ${destination}");
  //
  //     if (polylineCoordinates != null) {
  //       polylineCoordinates.clear();
  //     }
  //
  //     if (polyLine.isNotEmpty) {
  //       polyLine.clear();
  //     }
  //
  //     PolylinePoints polylinePoints = PolylinePoints();
  //
  //     result = await polylinePoints
  //         .getRouteBetweenCoordinates(
  //       MapData.googleMapToken,
  //       PointLatLng(source.latitude, source.longitude),
  //       PointLatLng(destination.latitude, destination.longitude),
  //     )
  //         .catchError((errr) {
  //       print("Polyline error :: ${errr.toString()}");
  //     });
  //
  //     print("Result  :::: ${result.points}");
  //
  //     result.points.asMap().forEach((int index, element) {
  //       polylineCoordinates.add(LatLng(element.latitude, element.longitude));
  //     });
  //
  //     polyLine.add(new Polyline(
  //       polylineId: PolylineId("source-to-destination"),
  //       points: polylineCoordinates,
  //       color: AppColors.orange,
  //       width: 1,
  //     ));
  //   } on Exception catch (e) {
  //     // TODO
  //
  //     print("Polyline error :: 33 ${e.toString()}");
  //   }
  //
  //   return result;
  // }

  zoomBtwSourceAndDestination(
      LatLng source, LatLng destination, GoogleMapController mapController) {
    LatLngBounds bound =
        LatLngBounds(southwest: source, northeast: destination);

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);
    mapController.animateCamera(u2).then((void v) {
      check(u2, mapController);
    });
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print("L1" + l1.toString());
    print("L2" + l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }

  // setDeliveryManCurrentLocation() async {
  //   print("setDeliveryManCurrentLocation");
  //
  //   BackgroundLocation.startLocationService();
  //
  //   BackgroundLocation.startLocationService(forceAndroidLocationManager: true);
  //
  //
  //
  //   var _firebaseDb = await  FirebaseDatabase.instance;
  //
  //   var _delivery_man = _firebaseDb.ref(FirebaseKey.DELIVERY_MAN);
  //
  //   await BackgroundLocation.setAndroidConfiguration(2000);
  //
  //   await BackgroundLocation.startLocationService(distanceFilter: 100);
  //
  //   BackgroundLocation.getLocationUpdates((location) {
  //     currentLocation.value = LatLng(location.latitude!, location.longitude!);
  //     _delivery_man
  //         .child(ProfileController
  //             .to.profileInfoDetails.value.response!.deliveryMenId
  //             .toString())
  //         .update({
  //       "${FirebaseKey.DELIVERY_MAN_LAT}": location.latitude,
  //       "${FirebaseKey.DELIVERY_MAN_LAN}": location.longitude,
  //     });
  //   });
  // }
}
