import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static void errorSnackbar({required String msg}) {
    Get.snackbar("Error !", msg,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        icon: Icon(Icons.error),
        duration: Duration(seconds: 1),
        colorText: Colors.white);
  }

  static void successSnackbar({required String? msg}) {
    Get.snackbar('$msg', "Success !",
        duration: Duration(seconds: 1),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[200],
        icon: Icon(
          Icons.check_circle_outline_outlined,
          color: Colors.white,
        ),
        colorText: Colors.white);
  }
}
