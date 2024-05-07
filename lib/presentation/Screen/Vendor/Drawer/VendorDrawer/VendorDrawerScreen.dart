import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/data/model/VendorModel.dart';
import 'package:single_vendor_admin/data/repository/Local/DataSource/MySharedPreference.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';
import 'package:single_vendor_admin/main.dart';
import 'package:single_vendor_admin/presentation/Routes/AppsRoutes.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/Controller/AuthenticationController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Drawer/VendorDrawer/vendor_drawer_controller.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HomePage/Controller/VendorHomePageController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HomePage/Controller/VendorHomeView.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/DrawerButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/ImageViewWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppAseets.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

class VendorDrawerScreen extends StatelessWidget {
  GlobalKey<ScaffoldState>? Key;

  VendorDrawerScreen();

  String vendorName = "Vendor Name";
  String vendorLocation = "Axies USA ";

  late BuildContext context;

  bool expendedOrder = false;

  @override
  Widget build(BuildContext context) {
    Get.put(VendorDrawerController());

    this.context = context;
    //  _vendorHomePage = new VendorHomePage();
    return SafeArea(
      child: Container(
        width: Get.width / 1.6,
        height: Get.height,
        decoration: BoxDecoration(color: AppColors.drawerBackgroundColor),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpaces.spaces_height_25,
              _image_pick_and_view(),
              _basic_info(),
              AppSpaces.spaces_height_25,
              _buttons()
            ],
          ),
        ),
      ),
    );
  }

  Widget _image_pick_and_view() {
    return Obx(() => Stack(
          children: [
            ImageViewWidget(
              borderEnable: true,
              imageSize: 150,
              imageType: ImageType.RING,
              imageUrl: ProfileController.to.vendorModel == null
                  ? AppAssets.demo_profile_image
                  : URL.host_url +
                      ProfileController.to.vendorModel.value.vendorImage
                          .toString(),
            ),
            Positioned(
              right: 10,
              bottom: 15.0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.camera_alt,
                  size: 10,
                ),
              ),
            )
          ],
        ));
  }

  _basic_info() {
    return Obx(() => Column(
          children: [
            AppSpaces.spaces_height_25,
            Text(
              ProfileController.to.vendorModel == null
                  ? ""
                  : ProfileController.to.vendorModel.value.fullName.toString(),
              style: Get.textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                ProfileController.to.vendorModel.value != null
                    ? ProfileController.to.vendorModel.value.address ?? ""
                    : '',
                style: Get.textTheme.bodyText2!.copyWith(fontSize: 12),
              ),
            ),
            AppSpaces.spaces_height_10,
            AppButtonWidget(
                onTab: () {
                  VendorHomePageController.to.setVendorHomeView(
                      vendorHomeView: VendorHomeView.EDIT_PROFILE);

                  Get.back();
                },
                title: language.edit_profile,
                font_size: 10,
                leadingCenter: true,
                left_padding: 0,
                right_padding: 0,
                horizontal_padding: 0,
                height: 30,
                width: 100),
          ],
        ));
  }

  _buttons() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: DrawerButtonWidget(
              onTab: () {
                Get.back();
                VendorHomePageController.to
                    .setVendorHomeView(vendorHomeView: VendorHomeView.BANNER);
              },
              icon: Icons.tv,
              title: "Banner",
            ),
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.all(1.0),
                child: DrawerButtonWidget(
                    onTab: () {
                      VendorDrawerController.to.isOpenKitchen.value =
                          !VendorDrawerController.to.isOpenKitchen.value;
                    },
                    icon: Icons.fastfood_rounded,
                    title: "Order Status",
                    suffixIcon: RotatedBox(
                        quarterTurns:
                            VendorDrawerController.to.isOpenKitchen.value
                                ? 3
                                : 2,
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                        ))),
              )),
          Obx(() {
            return Visibility(
              visible: VendorDrawerController.to.isOpenKitchen.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpaces.spaces_height_15,
                  AppSpaces.spaces_height_15,
                  InkWell(
                    onTap: () {
                      VendorHomePageController.to.setVendorHomeView(
                          vendorHomeView: VendorHomeView.ORDER_ITEM_PICKED);

                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Text(
                        "New Order",
                        style: Get.textTheme.bodyText1,
                      ),
                    ),
                  ),
                  AppSpaces.spaces_height_5,
                  Divider(),
                  AppSpaces.spaces_height_5,
                  InkWell(
                    onTap: () {
                      VendorHomePageController.to.setVendorHomeView(
                          vendorHomeView: VendorHomeView.COOKING_ITEMS);

                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Text(
                        "Cooking",
                        style: Get.textTheme.bodyText1,
                      ),
                    ),
                  ),

                  AppSpaces.spaces_height_5,
                  Divider(),

                  // InkWell(
                  //   onTap: () {
                  //     // DrawerMenuController.to.changeMenuSelectedItem(2);
                  //     VendorHomePageController.to.setVendorHomeView(
                  //         vendorHomeView: VendorHomeView.READY_TO_DELIVERY);
                  //     // // globalKey.currentState.openEndDrawer();
                  //
                  //     Get.back();
                  //   },
                  //   child: Padding(
                  //       padding: EdgeInsets.only(left: 60),
                  //       child: Text(
                  //         "Ready to delivery",
                  //         style: Get.textTheme.bodyText1,
                  //       )),
                  // ),
                  AppSpaces.spaces_height_5,
                  //  Divider(),
                  // AppSpaces.spaces_height_5,
                  /*    InkWell(
                    onTap: () {
                      // DrawerMenuController.to.changeMenuSelectedItem(2);
                      VendorHomePageController.to.setVendorHomeView(
                          vendorHomeView: VendorHomeView.READY_TO_DELIVERY);
                      // // globalKey.currentState.openEndDrawer();

                      Get.back();
                    },
                    child: Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: Text(
                          "Ready to delivery",
                          style: Get.textTheme.bodyText1,
                        )),
                  ),*/
                  AppSpaces.spaces_height_15,
                  //AppSpaces.spaces_height_15,
                ],
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: DrawerButtonWidget(
                onTab: () {
                  // DrawerMenuController.to.changeMenuSelectedItem(2);
                  VendorHomePageController.to.setVendorHomeView(
                      vendorHomeView: VendorHomeView.ADD_PRODUCT_TYPE);
                  // // globalKey.currentState.openEndDrawer();
                  Navigator.pop(context);
                },
                icon: Icons.phonelink_ring_rounded,
                title: language.add_product_type),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: DrawerButtonWidget(
                onTab: () {
                  VendorHomePageController.to.setVendorHomeView(
                      vendorHomeView: VendorHomeView.ADD_PRODUCT);
                  Get.back();
                },
                icon: Icons.add,
                title: language.Add_Product),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(1.0),
          //   child: DrawerButtonWidget(
          //       onTab: () {
          //         VendorHomePageController.to.setVendorHomeView(
          //             vendorHomeView: VendorHomeView.ADD_ADDRESS);
          //         Get.back();
          //       },
          //       icon: Icons.location_on,
          //       title: language.Add_Address),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(1.0),
          //   child: DrawerButtonWidget(
          //       onTab: () {
          //         VendorHomePageController.to.setVendorHomeView(
          //             vendorHomeView: VendorHomeView.CREDENTIAL_INFORMATION);
          //         Get.back();
          //       },
          //       icon: Icons.date_range_sharp,
          //       title: language.Credential_Information),
          // ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: DrawerButtonWidget(
                onTab: () {
                  VendorHomePageController.to.setVendorHomeView(
                      vendorHomeView: VendorHomeView.DILIVERY_MAN);
                  Get.back();
                },
                icon: Icons.delivery_dining,
                title: "Delivery Man"),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: DrawerButtonWidget(
                onTab: () {
                  VendorHomePageController.to.setVendorHomeView(
                      vendorHomeView: VendorHomeView.HELP_AND_SUPPORT);
                  //   DrawerMenuController.to.changeMenuSelectedItem(8);
                  Get.back();
                },
                icon: Icons.help_outline,
                title: language.Help_And_Support),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: DrawerButtonWidget(
                onTab: () {
                  VendorHomePageController.to.setVendorHomeView(
                      vendorHomeView: VendorHomeView.ABOUT_APP);
                  Get.back();
                },
                icon: Icons.device_hub,
                title: language.about_app),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: DrawerButtonWidget(
                icon: Icons.logout,
                title: language.Log_Out,
                onTab: () {
                  MySharedPreferenceController.to.sp.clear().then((value) {
                    ProfileController.to.vendorModel.value = new VendorModel();
                    VendorHomePageController.to.vendorHomeView =
                        VendorHomeView.ADD_PRODUCT_TYPE;

                    Get.reload();
                    Phoenix.rebirth(context);
                    Get.offAllNamed(AppRoutes.LOG_IN);
                  });
                }),
          ),

          ProfileController.to.vendorModel.value.fullName == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: DrawerButtonWidget(
                      color: Colors.red,
                      icon: Icons.delete,
                      title: "Delete Account",
                      onTab: () {

                        AuthenticationController.to.deleteVendorAccount();
                        MySharedPreferenceController.to.sp
                            .clear()
                            .then((value) {
                          ProfileController.to.vendorModel.value =
                              new VendorModel();
                          VendorHomePageController.to.vendorHomeView =
                              VendorHomeView.ADD_PRODUCT_TYPE;

                          Get.reload();
                          Phoenix.rebirth(context);
                          Get.offAllNamed(AppRoutes.LOG_IN);
                        });
                      }),
                ),
        ],
      ),
    );
  }
}
