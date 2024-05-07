import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HomePage/Controller/VendorHomePageController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HomePage/Controller/VendorHomeView.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:get/get.dart';

import '../../main.dart';

Widget AppBarWidget(
        {bool isCenterTitle = false,
        Text? title,
        bool menuButtonEnable = false,
        Color backgroundColor = AppColors.orange,
        VoidCallback? leadingCallBack,
        var key}) =>
    AppBar(
      key: key,
      backgroundColor: backgroundColor ?? Colors.white,
      title: GetBuilder<VendorHomePageController>(
          autoRemove: false,
          init: VendorHomePageController(),
          builder: (_) {
            print("Tab Title  ::  ${_.vendorHomeView}");
            switch (_.vendorHomeView) {
              case VendorHomeView.ADD_PRODUCT_TYPE:
                return Text(language.add_product_type);
              case VendorHomeView.ADD_PRODUCT:
                return Text(language.Add_Product);
              case VendorHomeView.NEW_ORDER:
                return Text(language.New_order);
              case VendorHomeView.CREDENTIAL_INFORMATION:
                return Text(language.Credential_Information);
              case VendorHomeView.HELP_AND_SUPPORT:
                return Text(language.Help_And_Support);
              case VendorHomeView.ADD_ADDRESS:
                return Text(language.Add_Address);
              case VendorHomeView.ADD_OFFER:
                return Text(language.add_offer);
              case VendorHomeView.EDIT_PROFILE:
                return Text(language.edit_profile);
              case VendorHomeView.ABOUT_APP:
                return Text(language.about_app);
              case VendorHomeView.ORDER_ITEM_PICKED:
                return Text(language.order_item_picked);
              case VendorHomeView.READY_TO_DELIVERY:
                return Text("Ready to delivery");
              case VendorHomeView.COOKING_ITEMS:
                return Text("Cooking Items");
              case VendorHomeView.DILIVERY_MAN:
                return Text("Delivery Man");
              case VendorHomeView.BANNER:
                return Text("Banner");
                break;
              default:
                return Text("Home");
            }
          }),
      centerTitle: isCenterTitle,
      leading: menuButtonEnable
          ? InkWell(
              onTap: leadingCallBack,
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            )
          : InkWell(
              onTap: leadingCallBack,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
    );
