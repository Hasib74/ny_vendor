import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              width: Get.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Do you want to exit this app?",
                      style: Get.textTheme.bodyLarge,
                    ),
                  ),
                  AppSpaces.spaces_height_15,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "No",
                            style: Get.textTheme.bodyText1!
                                .copyWith(color: Colors.red),
                          ),
                        ),
                        AppSpaces.spaces_width_25,
                        InkWell(
                          onTap: () {
                            exit(0);
                          },
                          child: Text(
                            "Yes",
                            style: Get.textTheme.bodyText1!
                                .copyWith(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
