import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:get/get.dart';

import '../../main.dart';

Widget AppButtonWidget(
    {String? title,
    bool leadingCenter = false,
    VoidCallback? onTab,
    double horizontal_padding = 10,
    double evulation = 2.0,
    Color backgroundColor = AppColors.orange,
    Color titleColor = Colors.white,
    bool borderEnable = false,
    Color borderColor = AppColors.orange,
    IconData? icon,
    Color iconColor = Colors.black54,
    double? width,
    TextStyle? textStyle,
    double borderRadius = 5,
    double left_padding = 16,
    double right_padding = 16,
    double font_size = 15,
    double height = 40,
    }) {
  return Padding(
    padding: EdgeInsets.only(
      left: horizontal_padding,
      right: horizontal_padding,
    ),
    child: InkWell(
      onTap: onTab,
      child: Container(
          padding: EdgeInsets.all(10),
          width: width ?? Get.width,
          height: height,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              border: borderEnable
                  ? Border.all(width: 2, color: borderColor)
                  : null),
          child: Row(
            mainAxisAlignment: leadingCenter
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              icon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        icon,
                        size: 17,
                        color: iconColor,
                      ),
                    )
                  : Container(),
              Text(
                '${title}',
                style: textStyle ??
                    TextStyle(
                        color: titleColor,
                        fontSize: font_size,
                        fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    ),
  );
}
