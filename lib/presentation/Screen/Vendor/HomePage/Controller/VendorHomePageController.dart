import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/VendorModel.dart';
import 'package:single_vendor_admin/data/repository/Repositories/VendorRepository.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstantData.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HomePage/Controller/VendorHomeView.dart';
import 'package:get/get.dart';

class VendorHomePageController extends GetxController {
  VendorHomeView? vendorHomeView;
  int menuIndex = 1;
  VendorRepository _vendorRepository = new VendorRepository();

  static VendorHomePageController get to => Get.find();

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    vendorHomeView = VendorHomeView.ADD_PRODUCT_TYPE;

  }

  setVendorHomeView({required VendorHomeView vendorHomeView}) {

    this.vendorHomeView = vendorHomeView;
    update();
  }
 void setmenuHomeView() {
    update();
  }


}
