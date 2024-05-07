import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoController extends GetxController implements NetworkInfo {
  static NetworkInfoController to = Get.find();
  Connectivity dataConnectionChecker = new Connectivity();

  @override
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
