library fb_token_repository ;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_vendor_admin/data/Firebase/DataSource/FirebaseKey.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:get/get.dart';

@protected
class  FBTokenRepository {
  String _TAG = "FBTokenRepository";
   @protected
    tokenGetAndSendToFirebaseDB() {
    FirebaseMessaging.instance.getToken().then((value) {
      print("${_TAG} token is : ${value}");
      FirebaseDatabase.instance
          .ref()
          .child(FirebaseKey.DEVICE_TOKEN)
          .child(FirebaseKey.VENDOR)
          .child(ProfileController.to.vendorModel.value.phoneNumber!)
          .set({FirebaseKey.TOKEN: value});
    });
  }

  getFirebaseDeviceToken() async {
    String? _token = await FirebaseMessaging.instance.getToken();

    print("Device token is :: ${_token}");
    return _token;
  }
}
