import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:single_vendor_admin/presentation/Routes/AppsRoutes.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/LogIn/login_page.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/CredentialInformation/Controller/CredentialChnagedPasswordController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/CredentialInformation/Controller/CredentialInformationController.dart';
import 'package:single_vendor_admin/presentation/Widgets/RectangleButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/RingButtonWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppAseets.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {



    return Scaffold(
        backgroundColor: Colors.deepOrange,
        body: Center(
          child: Column(
            children: [
              Spacer(),
              Spacer(),
              _logo(),
              // Spacer(),
              AppSpaces.spaces_height_20,
              _title(),

              Spacer(),
              Spacer(),
              _orderFood_grocery_catering(),
              Spacer(),
              Spacer(),
              _menu_reward_account_order(),
              Spacer(),
            ],
          ),
        ));
  }

  Row _menu_reward_account_order() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppSpaces.spaces_width_10,
        RectangleButtonWidget(
          assetIcon: AppAssets.menuIcon,
          title: language.Menu,
        ),
        AppSpaces.spaces_width_10,
        RectangleButtonWidget(
          assetIcon: AppAssets.rewardsIcon,
          title: language.Reward,
        ),
        AppSpaces.spaces_width_10,
        RectangleButtonWidget(
          assetIcon: AppAssets.accountIcon,
          title: language.Account,
          onClick: () => Get.toNamed(AppRoutes.LOG_IN),
        ),
        AppSpaces.spaces_width_10,
        RectangleButtonWidget(
          assetIcon: AppAssets.myOrderIcon,
          title: language.My_order,
        ),
        AppSpaces.spaces_width_10,
      ],
    );
  }

  Text _title() {
    return Text("${language.fast_and_reliable_doorstep_delivery}",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20));
  }

  Container _logo() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('${AppAssets.runnerLogo}'),
      ),
    );
  }

  _orderFood_grocery_catering() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        RingButtonWidget(
            title: language.order_now, iconAsset: AppAssets.orderFoodIcon),
        RingButtonWidget(
            title: language.grocery, iconAsset: AppAssets.groceryIcon),
        RingButtonWidget(
            title: language.catering, iconAsset: AppAssets.cateringIcon),
      ],
    );
  }
}
