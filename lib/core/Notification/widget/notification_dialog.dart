import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDialogWidget extends StatelessWidget {
  String title;

  String body;

  NotificationDialogWidget({this.title = "title", this.body = "body"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: Get.height * 0.2,
          width: Get.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text("${title}"), Text("${body}")],
          ),
        ),
      ),
    );
  }
}
