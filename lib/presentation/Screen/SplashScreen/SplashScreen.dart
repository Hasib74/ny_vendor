import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:single_vendor_admin/presentation/Routes/AppsRoutes.dart';
import 'package:single_vendor_admin/presentation/Screen/HomePage/HomePage.dart';
import 'package:single_vendor_admin/presentation/utils/AppAseets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'Controller/SplashScreenController.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //_navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(
      SplashScreenController(),
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(color: Colors.white),
          child: Container(
            padding: EdgeInsets.all(20),
            width: 100,
            height: 100,
            child: Center(
              child: Image.asset(
                'assets/icon/logo.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
