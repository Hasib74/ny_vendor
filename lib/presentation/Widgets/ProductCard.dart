import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProducts/Controller/AddProductController.dart';
import 'package:single_vendor_admin/presentation/Widgets/ImageViewWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

import '../../main.dart';

AddProductController _addProductController = Get.find();

Widget ProductCard({
  String? productName,
  String? productType,
  String? price,
  String? description,
  String? image,
  String stock = "0",
  String? offerAmount,
  VoidCallback? edit,
  VoidCallback? delete,
  VoidCallback? addStock,
}) {
  print("Image................  ${image}");
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
    child: Container(
      width: Get.width,
      height: 200,
      decoration: BoxDecoration(
          color: AppColors.card_background_color,
          border: Border.all(color: AppColors.gray),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          Row(
            children: [
              ImageViewWidget(
                  imageUrl: image ?? _addProductController.productDemoImagePath,
                  width: 80,
                  height: 80),
              AppSpaces.spaces_width_25,
              _productName_and_type_and_price(
                  productName, productType, price, stock, offerAmount),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description ??
                  "A product description is the marketing copy that explains what a product is and why it's worth purchasing. The purpose of a product description is to supply customers with important information about the features and benefits of the product so they're compelled to buy.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Spacer(),
          _edit_and_delete(addStock, edit, delete),
          AppSpaces.spaces_height_10,
        ],
      ),
    ),
  );
}

Column _productName_and_type_and_price(
    String? productName, String? productType, price, stock, offerAmount) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppSpaces.spaces_height_10,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName ?? "Samashed Burger - The Mirage",
            style: Get.textTheme.headline6!.copyWith(fontSize: 14),
          ),
          AppSpaces.spaces_height_10,
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            productType ?? "  Fast Food  ",
                            style: Get.textTheme.bodyText1!
                                .copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w600)
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    //AppSpaces.spaces_width_10,
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "\$ ${price} " ?? " \$ 120  ",
                          style: Get.textTheme.bodyText1!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w600)
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                    AppSpaces.spaces_width_10,
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Stock : ${stock}",
                            style: Get.textTheme.bodyText1!
                                .copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w600)
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),

                    AppSpaces.spaces_width_10,
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "${offerAmount}",
                            style: Get.textTheme.bodyText1!
                                .copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w600)
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

_edit_and_delete(
    VoidCallback? addStock, VoidCallback? edit, VoidCallback? delete) {
  return Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: addStock,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  "  ${language.update_stcok}  ",
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
          onTap: edit,
          child: Container(
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
            decoration: BoxDecoration(
                color: Colors.red,
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
      ],
    ),
  );
}
