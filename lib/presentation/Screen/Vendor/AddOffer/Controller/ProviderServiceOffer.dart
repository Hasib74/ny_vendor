import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/ProductOfferModel.dart';
import 'package:single_vendor_admin/data/repository/remote/Respositoris/VendorRemoteRepository.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstant.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';

class ProviderServiceOfferController extends GetxController {
  static ProviderServiceOfferController to = Get.find();
  TextEditingController offerNameTextController = new TextEditingController();
  TextEditingController offerCodeTextController = new TextEditingController();
  TextEditingController offerAmountTextController = new TextEditingController();
  TextEditingController offerUnitTextController = new TextEditingController();
  TextEditingController offerDescriptionTextController =
      new TextEditingController();
  VendorRemoteRepository _vendorRemoteRepository = new VendorRemoteRepository();
  Rx<ProductOfferModel?> vendorOffer = new ProductOfferModel().obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  saveVendorServiceOffer() async {
    if (vendorOffer.value != null) {
      updateVendorOffer();
    } else if (offerInfoFormValidation() && isDataChangeValidation()) {
      loading.value = true;
      String name, code, description, offer_unit;
      name = offerNameTextController.text;
      code = offerCodeTextController.text;
      description = offerDescriptionTextController.text;
      int amount = int.parse(offerAmountTextController.text);
      offer_unit = offerUnitTextController.text;

      Either<Response, Failure> response = await _vendorRemoteRepository
          .saveVendorProductOffer(name, code, description, amount, offer_unit);

      response.fold((l) {
        if (l.body[AppConstant.success].toString() == 'true') {
          AppSnackBar.successSnackbar(msg: "Offer Successfully Saved");
        } else {
          AppSnackBar.errorSnackbar(msg: 'Offer Operation Failed');
        }
      }, (r) {
        AppSnackBar.errorSnackbar(msg: ' Operation Failed');
      });
      loading.value = false;
    }
  }

  updateVendorOffer() async {
    if (offerInfoFormValidation() == false ||
        isDataChangeValidation() == false) {
      return;
    }
    loading.value = true;
    vendorOffer.value!.offerName = offerNameTextController.text;
    vendorOffer.value!.offerCode = offerCodeTextController.text;
    vendorOffer.value!.offerDescription = offerDescriptionTextController.text;
    vendorOffer.value!.offerAmount = offerAmountTextController.text;
    vendorOffer.value!.offerUnit = offerUnitTextController.text;

    Either<Response, Failure> response = await _vendorRemoteRepository
        .updateVendorOfferDetails(vendorOffer.value!);

    response.fold((l) {
      if (l.body[AppConstant.success].toString() == 'true') {
        AppSnackBar.successSnackbar(msg: "Offer Successfully Updated");
      } else {
        AppSnackBar.errorSnackbar(msg: 'Update Operation Failed');
      }
    }, (r) {
      AppSnackBar.errorSnackbar(msg: ' Operation Failed');
    });
    loading.value = false;
  }

  getVendorServiceOffer() async {
    loading.value = true;
    vendorOffer.value =
        await _vendorRemoteRepository.getVendorOfferInformation();
    if (vendorOffer.value != null) {
      offerUnitTextController.text = vendorOffer.value!.offerUnit!;
      offerNameTextController.text = vendorOffer.value!.offerName!;
      offerCodeTextController.text = vendorOffer.value!.offerCode!;
      offerDescriptionTextController.text = vendorOffer.value!.offerDescription!;
      offerAmountTextController.text = vendorOffer.value!.offerAmount.toString();
    }
    loading.value = false;
  }

  bool offerInfoFormValidation() {
    if (offerNameTextController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: 'Offer Name is Required');
      return false;
    } else if (offerCodeTextController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: 'Offer Code is Required');
      return false;
    } else if (offerDescriptionTextController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: 'Offer Description is Required');
      return false;
    } else if (offerAmountTextController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: 'Offer Amount is Required');
      return false;
    } else if (offerUnitTextController.text.isEmpty) {
      AppSnackBar.errorSnackbar(msg: 'Offer Unit (Tk/Percent) is Required');
      return false;
    }
    return true;
  }

  bool isDataChangeValidation() {
    bool _isChanged = false;

    if (vendorOffer.value != null &&
        !offerUnitTextController.value.text
            .endsWith(vendorOffer.value!.offerUnit!)) {
      _isChanged = true;
    }
    if (vendorOffer.value != null &&
        !offerNameTextController.value.text
            .endsWith(vendorOffer.value!.offerName!)) {
      _isChanged = true;
    }
    if (vendorOffer.value != null &&
        !offerCodeTextController.value.text
            .endsWith(vendorOffer.value!.offerCode!)) {
      _isChanged = true;
    }
    if (vendorOffer.value != null &&
        !offerDescriptionTextController.value.text
            .endsWith(vendorOffer.value!.offerDescription!)) {
      _isChanged = true;
    }
    if (vendorOffer.value != null &&
        !offerAmountTextController.value.text
            .endsWith(vendorOffer.value!.offerAmount.toString())) {
      _isChanged = true;
    }

    if (!_isChanged)
      AppSnackBar.errorSnackbar(msg: "Please change filed data before update.");

    return _isChanged;
  }

  void messageSnackbar({required String msg, required String title}) {
    Get.snackbar('$msg', title,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.deepOrange[200],
        colorText: Colors.white);
  }

  clearAllRequiredField() {
    offerNameTextController.clear();
    offerCodeTextController.clear();
    offerAmountTextController.clear();
    offerDescriptionTextController.clear();
  }
}
