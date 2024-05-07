import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:get/get.dart';

Widget dropDownButtonWidget({VoidCallback? onTab, String? selectedItem}) {
  return Container(
    height: 43,
    decoration: BoxDecoration(
      color: AppColors.text_fileld_color,
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    child: Row(
      children: [
        AppSpaces.spaces_width_15,
        Text(
          selectedItem ?? "Name",
          style: Get.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(Icons.arrow_drop_down),
        AppSpaces.spaces_width_15,
      ],
    ),
  );
}
