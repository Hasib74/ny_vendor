import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Banner/model/banner_model.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Banner/service/banner_service.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';

class BannerController extends GetxController {
  static BannerController to = Get.find();

  TextEditingController bannerNameController = TextEditingController();
  BannerService _bannerService = new BannerService();

  Rx<BannerModel> bannerModel = new BannerModel().obs;

  RxBool isLoading = false.obs;

  Rx<XFile> bannerImage = XFile("").obs;

  getBanner() async {
    isLoading.value = true;
    BannerModel? _banner = await _bannerService.getBanner();

    isLoading.value = false;

    if (_banner != null) {
      bannerModel.value = _banner;

      update();
    } else {
      AppSnackBar.errorSnackbar(msg: "Banner not found");
    }
  }

  createBanner(BuildContext context) {
    if (bannerImage.value.path.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Please select banner image");

      return;
    }

    if (bannerNameController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Please enter banner name");

      return;
    }
    isLoading.value = true;

    _bannerService
        .createOrUpdateBanner(
            File(bannerImage.value.path), bannerNameController.text)
        .then((value) {
      isLoading.value = false;
      if (value!) {
        AppSnackBar.successSnackbar(msg: "Banner created successfully");

        bannerImage.value = XFile("");
        bannerNameController.text = "";

        getBanner();

        Navigator.pop(context);
      } else {
        AppSnackBar.errorSnackbar(msg: "Banner not created");
      }
    });
  }

  void updateBanner(BuildContext context, num num, String? imgeurl) {
    // if (bannerImage.value.path.isEmpty) {
    //   AppSnackBar.errorSnackbar(msg: "Please select banner image");
    //
    //   return;
    // }

    if (bannerNameController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: "Please enter banner name");

      return;
    }
    isLoading.value = true;

    _bannerService
        .createOrUpdateBanner(
            File(bannerImage.value.path), bannerNameController.text,
            url: URL.bannerUpdate + num.toString())
        .then((value) {
      isLoading.value = false;
      if (value!) {
        AppSnackBar.successSnackbar(msg: "Banner update successfully");

        bannerImage.value = XFile("");
        bannerNameController.text = "";

        getBanner();

        Navigator.pop(context);
      } else {
        AppSnackBar.errorSnackbar(msg: "Banner not created");
      }
    });
  }

  void deleteBanner(num num) async {
    isLoading.value = true;
    _bannerService.deleteBanner(num)?.then((value) {
      if (value) {
        AppSnackBar.successSnackbar(msg: "Banner deleted successfully");

        isLoading.value = true;

        getBanner();
      } else {
        AppSnackBar.errorSnackbar(msg: "Banner not deleted");
      }
    });
  }
}
