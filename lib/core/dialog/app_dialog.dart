import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

class AppDialog {
  static showDialog({
    required BuildContext context,
    required String title,
    required String description,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: description,
      // btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }
}
