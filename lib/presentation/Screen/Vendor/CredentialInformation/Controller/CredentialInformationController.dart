import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/bank_info_model.dart';
import 'package:single_vendor_admin/data/repository/Repositories/VendorRepository.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';
import 'package:get/get.dart';

class CredentialInformationController extends GetxController {
  TextEditingController bankHolderController = new TextEditingController();
  TextEditingController accountNumberController = new TextEditingController();
  TextEditingController bankNameController = new TextEditingController();

  static CredentialInformationController to = Get.find();

  VendorRepository _vendorRepository = new VendorRepository();

  RxBool loading = false.obs;
  Rx<BankInfoModel> bankInfo = new BankInfoModel().obs;
  bool? isActive;

  @override
  void onInit() {
    update();
    //getBankInfo();

    initialTextFiledValue();

    loading = false.obs;
    super.onInit();
  }

  initialTextFiledValue() {
    if (bankInfo.value.bankHolder != null) {
      bankHolderController.text = bankInfo.value.bankHolder;
      accountNumberController.text = bankInfo.value.accountNumber;
      bankNameController.text = bankInfo.value.bankName;
    }
  }

  createBankInfo() async {
    if (validation()) {
      loading.value = true;

      Map _body = {
        "bank_holder": bankHolderController.value.text,
        "account_number": accountNumberController.value.text,
        "bank_name": bankNameController.value.text
      };

      var response = await _vendorRepository.creteBankInfo(jsonEncode(_body));
      response.fold((l) {
        printInfo(info: "Response ============> ${l["success"]}");

        if (l["success"].toString().endsWith("true")) {
          AppSnackBar.successSnackbar(msg: l["message"]);
        } else {
          AppSnackBar.errorSnackbar(msg: l["message"]);
        }
      }, (r) => print("Right ==========> ${r}"));
      loading.value = false;
    }
  }

  updateBankInfo() async {
    if (validation()) {
      loading.value = true;

      Map _body = {
        "bank_holder": bankHolderController.value.text,
        "account_number": accountNumberController.value.text,
        "bank_name": bankNameController.value.text
      };

      var response = await _vendorRepository.updateBankInfo(jsonEncode(_body));
      response.fold((l) {
        printInfo(info: "Response ============> ${l["success"]}");

        if (l["success"].toString().endsWith("true")) {
          AppSnackBar.successSnackbar(msg: l["message"]);
        } else {
          AppSnackBar.errorSnackbar(msg: l["message"]);
        }
      }, (r) => print("Right ==========> ${r}"));
      loading.value = false;
    }
  }

/*  getBankInfo() async {
    try {
      Either<Response, Failure> response = await _vendorRepository.getBankInfo();
      
      response.
      fold((l) {
        print("Bank Info ==========> ${l.body}");
      
        bankInfo.value = BankInfoModel.fromJson(l.body);
      
        initialTextFiledValue();
      }, (r) {
        print("Bank Info error==========> ${r.toString()}");
      });
    } on Exception catch (e) {
      // TODO
    }
  }*/

  bool validation() {
    bool isValidation;

    if (bankHolderController.value.text.isEmpty) {
      isValidation = false;
      AppSnackBar.errorSnackbar(msg: "Bank holder name is required");
    } else if (accountNumberController.value.text.isEmpty) {
      isValidation = false;
      AppSnackBar.errorSnackbar(msg: "Account number is required");
    } else if (bankNameController.value.text.isEmpty) {
      isValidation = false;
      AppSnackBar.errorSnackbar(msg: "Bank Nmme is required");
    } else {
      isValidation = true;
    }
    return isValidation;
  }
}
