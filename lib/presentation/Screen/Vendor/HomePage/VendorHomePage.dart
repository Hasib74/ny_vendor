import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/data/Firebase/FirebaseRepoManeger.dart';
import 'package:single_vendor_admin/presentation/Screen/AppSetting/About/AboutScreen.dart';
import 'package:single_vendor_admin/presentation/Screen/Dialog/exit_dialog.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddAddress/AddAddress.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddOffer/ProviderServiceOffer.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProductType/AddProductType.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProductType/Controller/AddProductTypeController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProducts/product_list.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/CredentialInformation/CredentialInformation.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/DeliveryMan/delivery_man_list_screen.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Drawer/VendorDrawer/VendorDrawerScreen.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/EditProfile/EditProfile.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HelpAndSupport/HelpAndSupport.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HomePage/Controller/VendorHomePageController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HomePage/Controller/VendorHomeView.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/CookingItems/cooking_items.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/OrderPickedItem/OrderItemsPicked.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/OrderReportMenuScreen.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/Ready%20To%20Delivery/ready_to_delivery_screen.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppBarWidget.dart';

import '../Banner/banner_screen.dart';

class VendorHomePage extends StatelessWidget {
  GlobalKey<ScaffoldState> globalKey = new GlobalKey();

  final bool? isNotification;

  VendorHomePage({this.isNotification}) {
    if (this.isNotification != null && this.isNotification == true) {
      VendorHomePageController.to.vendorHomeView =
          VendorHomeView.ORDER_ITEM_PICKED;

      Future.delayed(Duration.zero).then((value) {
        VendorHomePageController.to.update();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //_vendorHomePageController

    ProfileController.to.getVendorProfile().then((value) async {
      String _deviceToken =
          await FirebaseRepoManager.fbTokenRepository.getFirebaseDeviceToken();

      print("DeviceToken ............ ${_deviceToken}");
      ProfileController.to.saveDeviceToken(_deviceToken);

      ProductTypeController.to.getProductType();
    });

    return WillPopScope(
      onWillPop: () async {
        printInfo(
            info:
                "VendorHomePageController.to.vendorHomeView ::: ${VendorHomePageController.to.vendorHomeView}");
        if (VendorHomePageController.to.vendorHomeView ==
            VendorHomeView.ADD_PRODUCT_TYPE) {
          Get.dialog(ExitDialog());
        } else {
          VendorHomePageController.to.vendorHomeView =
              VendorHomeView.ADD_PRODUCT_TYPE;

          VendorHomePageController.to.update();
        }

        return true;
      },
      child: Scaffold(
        key: globalKey,
        appBar: AppBarWidget(
          //key: globalKey,
          leadingCallBack: () {
            globalKey.currentState!.openDrawer();
            //    Get
          },
          menuButtonEnable: true,
        ) as PreferredSizeWidget?,
        drawer: VendorDrawerScreen(),
        body: Container(
          height: Get.height,
          width: Get.width,
          child: GetBuilder<VendorHomePageController>(
              autoRemove: false,
              init: VendorHomePageController(),
              builder: (_) {
                switch (_.vendorHomeView) {
                  case VendorHomeView.ADD_PRODUCT_TYPE:
                    return AddProductType();
                  case VendorHomeView.ADD_ADDRESS:
                    return AddAddress();
                  case VendorHomeView.ADD_PRODUCT:
                    return ProductList();
                  case VendorHomeView.CREDENTIAL_INFORMATION:
                    return CredentialInformation();
                  case VendorHomeView.NEW_ORDER:
                    return OrderReportMenuScreen(); // NewOrderScreen();
                  case VendorHomeView.ADD_OFFER:
                    return AddOffer();
                  case VendorHomeView.HELP_AND_SUPPORT:
                    return HelpAndSupport();
                  case VendorHomeView.EDIT_PROFILE:
                    return EditProfile();
                  case VendorHomeView.ABOUT_APP:
                    return AboutScreen();
                  case VendorHomeView.ORDER_ITEM_PICKED:
                    return OrderItemsPicked();
                  case VendorHomeView.READY_TO_DELIVERY:
                    return ReadyToDeliveryScreen();
                  case VendorHomeView.COOKING_ITEMS:
                    return CookingItemsScreen();
                  case VendorHomeView.DILIVERY_MAN:
                    return DeliveryManScreen();

                  case VendorHomeView.BANNER:
                    return BannerScreen();

                  default:
                    return HelpAndSupport();
                }
              }),
        ),
      ),
    );
  }

/* Text _title() {

  }*/
}
