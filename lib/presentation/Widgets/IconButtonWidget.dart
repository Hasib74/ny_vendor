import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';

Widget IconButtonWidget(
    {IconData? icon,
    bool isSelected = false,
    Color iconColor = Colors.white,
    double width = 60,
    double height = 40,
    Color? color,
    VoidCallback? onClick}) {
  color = AppColors.orange;
  return InkWell(
    onTap: onClick,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Center(
        child: Icon(
          icon,
          color: isSelected ? iconColor : Colors.black54,
        ),
      ),
    ),
  );
}
