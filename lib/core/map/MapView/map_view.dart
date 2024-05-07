import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as IMG;
import 'package:single_vendor_admin/Data/Firebase/DataSource/FirebaseKey.dart';
import 'package:single_vendor_admin/generated/assets.dart';

import '';
import '../../../Presentation/Widgets/AppLoading.dart';
import '../../../Presentation/utils/AppColors.dart';
import '../MapFunction.dart';
import 'Controller/AppMapController.dart';

class AppMapView extends StatefulWidget {
  LatLng? driverLatLng = LatLng(23.7985071, 90.3736547);
  LatLng? vendorLatLng = LatLng(23.7991501, 90.3739417);

  LatLng? orderAddressLatLng ;

  AppMapView(
      {Key? key, this.driverLatLng, this.orderAddressLatLng, this.vendorLatLng})
      : super(key: key);

  @override
  State<AppMapView> createState() => _AppMapViewState();
}

class _AppMapViewState extends State<AppMapView> {
  Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController googleMapController;

  LatLng? _lastMapPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.put(AppMapController());

    widget.driverLatLng = LatLng(23.7985071, 90.3736547);
    widget.vendorLatLng = LatLng(23.7991501, 90.3739417);
    widget.orderAddressLatLng = LatLng(23.8021806, 90.362456);

    _setMarkers();
  }

  @override
  Widget build(BuildContext context) {
    // AppMapController.to.getCurrentLocation().then((value) {
    //
    //   AppMapController.to.getPolylinePoints(driverLatLng, orderAddressLatLng);
    // });

    return Scaffold(
      body: SafeArea(
        child: Container(child: _body()),
      ),
    );
  }

  _body() {
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(widget.orderAddressLatLng!.latitude,
          widget.orderAddressLatLng!.longitude),
      zoom: 14.4746,
    );

    return Stack(
      children: [
        Positioned.fill(
          child: GoogleMap(
            //polylines: Set<Polyline>.of(AppMapController.to.polyLine.value.points),
            //  polylines: AppMapController.to.polyLine,

            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: AppMapController.to.markers,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: _mapCreated,
            onCameraMove: _onCameraMove,
          ),
        ),
        Positioned(
            top: 16,
            left: 16,
            child: FloatingActionButton(
              mini: true,
              child: Icon(Icons.arrow_back_ios_outlined),
              backgroundColor: AppColors.orange,
              onPressed: () {
                Get.back();
              },
            )),
      ],
    );
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _setMarkers() async {
    AppMapController.to.markers.clear();

    /*driverLatLng = widget
            .driverLatLng */ /*??
        LatLng(AppMapController.to.position.value.latitude,
            AppMapController.to.position.value.longitude)*/
    ;

    print("Driver Location :: ==>  ${widget.driverLatLng.toString()}");

    // orderAddressLatLng = orderAddressLatLng == null
    //     ? LatLng(23.81374083426752, 90.37027526646852)
    //     : orderAddressLatLng;

    _driverLocationMarker();

    if (widget.orderAddressLatLng != null) {
      // final Uint8List customMarker = await networkImageToByte(
      //     "https://img.icons8.com/doodle/344/gender-neutral-user.png");

      var _markerIconUnit8 = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(12, 12)), Assets.iconOrderPlaceMarker);

      print("Marker Icon Unit 8 :: ${_markerIconUnit8.toString()}");

      AppMapController.to.markers.add(new Marker(
          markerId: MarkerId("des"),
          infoWindow: InfoWindow(title: "Order Place"),
          icon: BitmapDescriptor.fromBytes(await MapFunction.getBytesFromAsset(
              Assets.iconOrderPlaceMarker, 100)),
          position: LatLng(widget.orderAddressLatLng!.latitude,
              widget.orderAddressLatLng!.longitude)));
    }
/*
    AppMapController.to.markers.add(new Marker(
        markerId: MarkerId("des"),
        infoWindow: InfoWindow(title: "Order Place"),
        icon: BitmapDescriptor.fromBytes(await MapFunction.getBytesFromAsset(
            Assets.iconVendorLocationMarker, 100)),
        position: LatLng(
            widget.vendorLatLng!.latitude, widget.vendorLatLng!.longitude)));*/

    print("AppMapController.to.markers  ${AppMapController.to.markers}");

    zoomCameraWithMultiMarkersPosition();

    /*   AppMapController.to.zoomBtwSourceAndDestination(
        orderAddressLatLng, destinationLatLng, googleMapController);*/

    setState(() {});

    ;
  }

  zoomCameraWithMultiMarkersPosition() async {
    print("Zooming location ....");
    print(
        "AppMapController.to.markers.toList() :: ==> ${AppMapController.to.markers.toList()}");

    var bounds = MapFunction.getBounds(AppMapController.to.markers.toList());

    LatLng centerBounds = LatLng(
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2);

    print("Center Bounds :: ${centerBounds.toString()}");

    Future.delayed(Duration.zero).then((value) {
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: centerBounds, zoom: 14)));
    });
  }

  Uint8List resizeImage(Uint8List data) {
    Uint8List resizedData = data;
    IMG.Image img = IMG.decodeImage(data)!;
    IMG.Image resized = IMG.copyResize(img,
        width: (img.width * 0.1).floor(), height: (img.height * 0.1).floor());
    resizedData = IMG.encodeJpg(resized) as Uint8List;
    return resizedData;
  }

  void _mapCreated(GoogleMapController controller) {
    this.googleMapController = controller;
    _controller.complete(controller);
  }

  void _driverLocationMarker() {
   /// print("Driver Location :: ==>  ${widget.driverLatLng.toString()}");
    FirebaseDatabase.instance
        .ref("delivery_man")
        .child("10")
        .onValue
        .listen((event) async {
      print("Driver Location :: ==> firebase ==>  ${event.snapshot.value.toString()}");

      var _driverLocation = event.snapshot.value;

      if (_driverLocation != null) {
        print("_driverLocation :: ==>  ${_driverLocation.toString()}");

        // AppMapController.to.markers.add(new Marker(
        //   markerId: MarkerId("source"),
        //   infoWindow: InfoWindow(title: "Driver Place"),
        //   icon: BitmapDescriptor.fromBytes(
        //       await MapFunction.getBytesFromAsset(Assets.iconCarMarker, 100)),
        //   position: LatLng(
        //       widget.driverLatLng!.latitude, widget.driverLatLng!.longitude),
        // ));
      }
    });
  }
}
