import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

Widget DrawerButtonWidget(
    {double height = 40,
    IconData? icon,
    double iconSize = 15,
    double borderRadius = 5,
    required String title,
    Widget? suffixIcon,
      Color? color,
    VoidCallback? onTab}) {
  return InkWell(
    onTap: onTab,
    child: Container(
      color: color ,
      width: double.infinity,
      height: height,
      child: Stack(
        children: [
          Positioned(
              left: 55,
              right: 0,
              child: Container(
                height: height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppSpaces.spaces_width_15,
                    Text(
                      title,
                      style: Get.textTheme.bodyText2,
                    ),
                    Spacer(),
                    suffixIcon ?? Container(),
                    if (suffixIcon != null) AppSpaces.spaces_width_15,
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.gray),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius))),
              )),
          Container(
            height: height,
            width: 60,
            decoration: BoxDecoration(
                color: color?? AppColors.orange,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
