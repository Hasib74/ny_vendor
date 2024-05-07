import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:get/get.dart';

import '../../main.dart';
import 'ImageViewWidget.dart';

Widget ProductTypeWidget(
    {String? productName,
    String? productType,
    VoidCallback? edit,
    VoidCallback? delete,
    String? productTypeImage}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
    child: Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.black12,
          //  color: Color(0xfffffaf6),
          border: Border.all(color: AppColors.gray),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppSpaces.spaces_width_10,
          /*  Column(
            children: [
              AppSpaces.spaces_height_10,
              Text(
                productName ?? "Samashed Burger - The Mirage",
                style: Get.textTheme.headline6.copyWith(fontSize: 16),
              ),
              AppSpaces.spaces_height_10,

              AppSpaces.spaces_height_10,
            ],
          ),*/

          AppSpaces.spaces_width_10,
          ImageViewWidget(
            imageUrl: productTypeImage ?? "assets/images/food.png",
            height: 40,
            width: 60,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                productName ?? "  Fast Food  ",
                maxLines: 2,
                style: Get.textTheme.bodyText1!
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w600)
                    .copyWith(color: AppColors.black),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          InkWell(
            onTap: edit,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    "  ${language.edit}  ",
                    style: Get.textTheme.bodyText1!.copyWith(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          AppSpaces.spaces_width_10,
          InkWell(
            onTap: delete,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    "  ${language.delete}  ",
                    style: Get.textTheme.bodyText1!.copyWith(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          AppSpaces.spaces_width_10,
        ],
      ),
    ),
  );
}
