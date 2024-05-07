import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';

class AppHUDLoading {
  bool _isShowing = false;

  show(BuildContext context) async {
    if (_isShowing == false) {
      _isShowing = true;
      showDialog(context: context, builder: (context) => AppLoading());
    }
  }

  dismiss(BuildContext context) async {
    if (_isShowing == true) {
      _isShowing = false;
      Navigator.pop(context);
    }
  }
}
