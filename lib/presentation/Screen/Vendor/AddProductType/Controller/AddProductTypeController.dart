import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/ProductTypeModel.dart';
import 'package:single_vendor_admin/data/repository/remote/Respositoris/VendorRemoteRepository.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstant.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';

class ProductTypeController extends GetxController {
  static ProductTypeController to = Get.find();
  VendorRemoteRepository vendorRemoteRepository = new VendorRemoteRepository();
  TextEditingController productTypeText = new TextEditingController();
  RxList<ProductTypeModel> productTypeList = <ProductTypeModel>[].obs;
  Rx<ProductTypeModel?> selectedProductType = ProductTypeModel().obs;
  RxInt selectedServieTypeId = 1.obs; // Restuarant
  RxString saveButtonTitle = "".obs;

  RxString? shouldUpdateProductTypeImage = "".obs;

  RxBool loading = false.obs;

  Rx<XFile> productTypeImage = XFile("").obs;

  @override
  void onInit() {
    // TODO: implement onInit

    updateProductTypeListWithUI();

    super.onInit();

    //  productTypeText.text ="Burger new";
  }

  addNewProductType() async {
    if (ProductTypeFormValidation()) {
      if (!ProductTypeController.to.saveButtonTitle.value.endsWith("Update")) {
        print("validation ok   " +
            ProfileController.to.vendorModel.value.id.toString());
        // Map<String, dynamic> result =
        // await vendorRemoteRepository.addNewProductTypeInfo(
        //     productTypeText.text,selectedServieTypeId, AppConstantData.vendorModel.id);
        // if (result["status_code"] == 200) {
        //   errorSnackbar(msg: "Product Added", title: "Success!");
        //   productTypeText.clear();
        //   updateProductTypeListWithUI();
        // }

        Either<Response, Failure> response =
            await vendorRemoteRepository.addNewProductTypeInfo(
                productTypeText.text,
                selectedServieTypeId.value,
                ProfileController.to.vendorModel.value.id,
                File(productTypeImage.value.path));
        // print("update is ${response}");

        response.fold((l) {
          print('product name added  ok ${l.body[AppConstant.message]}  ');
          if (l.body[AppConstant.success].toString() == 'true') {
            selectedProductType == null;
            AppSnackBar.successSnackbar(
                msg: "Product type added successfully.");
            productTypeText.clear();
            productTypeImage.value = XFile("");
            updateProductTypeListWithUI();
          } else {
            AppSnackBar.errorSnackbar(msg: "Failed to add product type.");
          }
        }, (r) {
          AppSnackBar.errorSnackbar(msg: 'Update Operation Failed');
          ;
        });
      } else {
        print("product type updated id " +
            selectedProductType.value!.id.toString());
        Either<Response, Failure> response =
            await vendorRemoteRepository.addNewProductTypeInfo(
                productTypeText.text,
                selectedServieTypeId.value,
                ProfileController.to.vendorModel.value.id,
                File(productTypeImage.value.path),
                imageUrl: shouldUpdateProductTypeImage?.value,
                isUpdate: true,
                productId: selectedProductType.value!.id);
        // print("update is ${response}");

        response.fold((l) {
          print('product update  ok ${l.body[AppConstant.success]}  ');
          if (l.body[AppConstant.success].toString() == 'true') {
            selectedProductType == null;
            AppSnackBar.successSnackbar(msg: "Updated product successfully.");
            productTypeText.clear();
            updateProductTypeListWithUI();
          } else {
            AppSnackBar.errorSnackbar(msg: 'This product is already added!');
          }
        }, (r) {
          AppSnackBar.errorSnackbar(msg: 'Update Operation Failed');
          ;
        });
      }
    } else {
      AppSnackBar.errorSnackbar(msg: "Product type filed can not be empty.");
    }
  }

  updateProductTypeListWithUI() async {
    // if (int.parse(ProfileController.to.vendorModel.value.id.toString()) > 0) {
    print("Calling API");

    loading(true);

    getProductType().then((value) {
      printInfo(info: "Product Type Value ${value}");

      productTypeList.value = value;

      loading(false);

      // print(" productTypeList.value ${value[0].id}");
    }).catchError((err) {
      printInfo(info: "Vendor type catch error : ${err.toString()}");
      loading(false);
    });

    //}
    saveButtonTitle.value = "Save";
  }

  Future<List<ProductTypeModel>> getProductType() async {
    loading(true);

    List<ProductTypeModel> _productTypeList =
        await vendorRemoteRepository.getAllProductTypesList();

    loading(false);

    productTypeList.value = _productTypeList;

    return _productTypeList;
  }

  deleteAProductType(productTypeId) async {
    Either<Response, Failure> response =
        await vendorRemoteRepository.deleteAProductType(productTypeId);
    // if(response['status_code'] == 200){
    //   errorSnackbar(msg: "Product Type Successfully Delete ", title: "Success");
    //   selectedProductType == null;
    //   productTypeText.clear();
    //   updateProductTypeListWithUI();
    //
    // }else {
    //   errorSnackbar(msg: "Failed", title: "Error!!");
    // }

    response.fold((l) {
      print('product   deteted  ok ${l.body[AppConstant.success]}  ');
      if (l.body[AppConstant.success].toString() == 'true') {
        selectedProductType == null;
        AppSnackBar.successSnackbar(msg: "Product type deleted successfully.");
        productTypeText.clear();
        updateProductTypeListWithUI();
      } else {
        AppSnackBar.errorSnackbar(msg: l.body[AppConstant.message].toString());
      }
    }, (r) {
      AppSnackBar.errorSnackbar(msg: 'Delete Operation Failed');
      ;
    });
  }

  openProductTypeForEditing() {
    productTypeText.text = selectedProductType.value!.productTypeName;

    productTypeText.selection = TextSelection.fromPosition(
        TextPosition(offset: productTypeText.text.length));

    print("open for editing is" + selectedProductType.value!.productTypeName);
  }

  ProductTypeFormValidation() {
    if (productTypeText.text.isEmpty) {
      // errorSnackbar(msg: "Product Type is not Empty", title: "Error!");
      return false;
    }

    return true;
  }

  void errorSnackbar({required String msg, required title}) {
    Get.snackbar('$msg', title,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.deepOrange[200],
        colorText: Colors.white);
  }

  void selectProductTypeImageFromGallery() async {
    productTypeImage.value = (await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500))!;

    print("image path is ${productTypeImage.value.path}");

    // productTypeImage.value = (await ImagePicker().pickImage(
    //     source: ImageSource.gallery,
    //     imageQuality: 50,
    //     maxHeight: 500,
    //     maxWidth: 500))!;
    //
    // print("image path is ${productTypeImage.value.path}");
  }

// addNewProduct(){
//   vendorRemoteRepository.addProductInformation("product 1","pro-100","this is demo  product",1,100,"",1);
// }
}
