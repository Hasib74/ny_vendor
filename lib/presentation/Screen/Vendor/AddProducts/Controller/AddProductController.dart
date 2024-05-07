import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/ProductNameModel.dart';
import 'package:single_vendor_admin/data/model/ProductTypeModel.dart';
import 'package:single_vendor_admin/data/repository/remote/Respositoris/VendorRemoteRepository.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstant.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProductType/Controller/AddProductTypeController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';

class AddProductController extends GetxController {
  static AddProductController to = Get.find();

  Rx<XFile> productSelectedImage = XFile("").obs;
  RxString imageUrl = "".obs;
  var productDemoImagePath =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRfpZB0_3qGRT0vx7Jlw662goIgQc9en4esg&usqp=CAU";
  RxList<ProductTypeModel> productCategoryList = <ProductTypeModel>[].obs;
  VendorRemoteRepository vendorRemoteRepository = new VendorRemoteRepository();
  TextEditingController productNameText = new TextEditingController();
  TextEditingController productPriceText = new TextEditingController();
  TextEditingController productDescriptionText = new TextEditingController();
  TextEditingController productCodeText = new TextEditingController();
  TextEditingController productStockTextField = TextEditingController();

  TextEditingController offerTextEditingController =
      new TextEditingController();

  TextEditingController searchTextEditingController =
      new TextEditingController();

  Rx<ProductTypeModel?> selectedProductCategory = ProductTypeModel().obs;

  RxList<ProductNames> producNameList = <ProductNames>[].obs;
  RxList<ProductNames> searchListProducts = <ProductNames>[].obs;
  RxBool isUpdate = false.obs;

  RxString selectedDropDownMenu = "".obs;

//  RxString selectedProductTypeName = "".obs;
//  Rx<ProductNameModel> productsAllInformation = new ProductNameModel().obs;
  Rx<ProductNames> selectedProductName = ProductNames().obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    selectedProductCategory = ProductTypeModel().obs;
    super.onInit();
    loading(false);

    // _getProductTypeList();

    print(" oninit calling for product name");
  }

  getProductsBySearch({String? search}) {
    searchListProducts.clear();

    producNameList.forEach((element) {
      if (element.productName!
          .toLowerCase()
          .contains(new RegExp(search!.toLowerCase(), caseSensitive: false))) {
        searchListProducts.add(element);

        searchListProducts.refresh();
      }
    });
  }

  Future<RxList<ProductTypeModel>> getProductCategoryList() async {
    productCategoryList.value = ProductTypeController.to.productTypeList.value;

    productCategoryList.value.forEach((element) {
      printInfo(info: "Product Name :: ${element.productTypeName}");
    });

    return productCategoryList;
    printInfo(info: "productCategoryList  ::: ${productCategoryList.length}");
  }

  getProductNames() async {
    printInfo(info: "Vendor all list Calling........");

    loading(true);
    producNameList.clear();
    ProductNameModel? _productNameModel =
        await vendorRemoteRepository.getProviderProductNamesList() ;

    try {
      _productNameModel!.products!.forEach((element) {
        element.productNames!.forEach((prod) {
          producNameList.add(prod);

          printInfo(info: "Product price :: ${prod.price}");

          loading(false);
        });
      });
    } catch (err) {
      loading(false);
      printInfo(info: "Error ::: ${err.toString()}");
    }

    loading(false);
  }

  Future saveNewProductInformation(BuildContext context) async {
    loading(true);

    Either<Response, Failure>? response;

    try {
      //  loading(true);
      String _file = File(productSelectedImage.value.path).path;
      if (_file.isNotEmpty || _file != null) {
        if (addNewProductFormValidation()) {
          print("p name : " + productNameText.text.toString());
          print("p code : " + productCodeText.text.toString());
          print("p type id : " +
              selectedProductCategory.value!.serviceTypeId.toString());
          print("Image File : " + _file.toString());

          response = await vendorRemoteRepository.addProductInformation(
            productNameText.text,
            "code",
            productDescriptionText.text,
            selectedProductCategory.value!.id.toString(),
            productPriceText.text,
            "imagePath",
            "1",
            offerTextEditingController.value.text,
            File(productSelectedImage.value.path),
          );

          //print("update is ${response}");

          response.fold((l) {
            print('product update  ok ${l.body[AppConstant.success]}  ');
            // loading(false);

            if (l.body[AppConstant.success].toString() == 'true') {
              AppSnackBar.successSnackbar(msg: "Product successfully Added ");
              clearAllRequiredField();

              loading(false);
              Navigator.pop(context);
              getProductNames();
            } else {
              loading(false);
              AppSnackBar.errorSnackbar(msg: 'Product Operation Failed');
            }
          }, (r) {
            loading(false);

            AppSnackBar.errorSnackbar(msg: "Image can not be empty.");
          });
        } else {
          loading(false);
        }
      } else {
        loading(false);
        AppSnackBar.errorSnackbar(msg: "Image can not be empty.");
      }
    } catch (err) {
      printInfo(info: "Error : ${err}");

      AppSnackBar.errorSnackbar(msg: "Image can not be empty.");
      loading(false);
    }

    return response;
  }

  deleteASelectedProductName(int? productNameId) async {
    Either<Response, Failure> response =
        await vendorRemoteRepository.deleteAProductName(productNameId);

    response.fold((l) {
      print('product delete  ok ${l.body[AppConstant.success]}  ');
      if (l.body[AppConstant.success].toString() == 'true') {
        AppSnackBar.successSnackbar(msg: "Product successfully deleted ");
        clearAllRequiredField();
        getProductNames();
      } else {
        AppSnackBar.errorSnackbar(msg: 'Product Operation Failed');
      }
    }, (r) {
      AppSnackBar.errorSnackbar(msg: ' Operation Failed');
      ;
    });
  }

  addProductStock(int? productNameId) async {
    loading(true);

    if (!productStockTextField.text.isNumericOnly) {
      AppSnackBar.errorSnackbar(msg: ' Invalid Number');
      loading(false);

      return;
    }
    Either<Response, Failure> response = await vendorRemoteRepository
        .addProductStock(productNameId, productStockTextField.value.text);

    response.fold((l) {
      if (l.body[AppConstant.success].toString() == 'true') {
        AppSnackBar.successSnackbar(msg: "Product Stock Successfully Updated ");

        AddProductController.to.productStockTextField.text = "";

        clearAllRequiredField();
        getProductNames();

        loading(false);
      } else {
        loading(false);

        AppSnackBar.errorSnackbar(msg: 'Stock Update Operation Failed');
      }
    }, (r) {
      loading(false);

      AppSnackBar.errorSnackbar(msg: ' Operation Failed');
    });
  }

  updateProductStock(int? productNameId) async {
    loading(true);

    if (!productStockTextField.text.isNumericOnly) {
      AppSnackBar.errorSnackbar(msg: ' Invalid Number');
      loading(false);

      return;
    }
    Either<Response, Failure> response = await vendorRemoteRepository
        .updateProductStock(productNameId, productStockTextField.value.text);

    response.fold((l) {
      if (l.body[AppConstant.success].toString() == 'true') {
        AppSnackBar.successSnackbar(msg: "Product Stock Successfully Updated ");

        AddProductController.to.productStockTextField.text = "";

        clearAllRequiredField();
        getProductNames();

        loading(false);
      } else {
        loading(false);

        AppSnackBar.errorSnackbar(msg: 'Stock Update Operation Failed');
      }
    }, (r) {
      loading(false);

      AppSnackBar.errorSnackbar(msg: ' Operation Failed');
    });
  }

  addNewProductFormValidation() {
    if (productNameText.text.isEmpty) {
      messageSnackbar(msg: "Product Name is required", title: "Error!");
      return false;
    } else if (productPriceText.text.isEmpty) {
      messageSnackbar(msg: "Product Price is required", title: "Error!");
      return false;
    } else if (selectedProductCategory == null ||
        selectedProductCategory.value!.id == 0) {
      messageSnackbar(msg: "Please Select Product Category", title: "Error!");
      return false;
    } else if (productDescriptionText.text.isEmpty) {
      messageSnackbar(msg: "Product Description is required", title: "Error!");
      return false;
    }

    return true;
  }

  productImageUIUpdate() {
    update();
  }

  void messageSnackbar({required String msg, required String title}) {
    Get.snackbar('$msg', title,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.deepOrange[200],
        colorText: Colors.white);
  }

  clearAllRequiredField() {
    productNameText.clear();
    productPriceText.clear();
    productPriceText.clear();
    productDescriptionText.clear();
    selectedProductCategory.value = new ProductTypeModel();
  }

  void setUpUpdate(ProductNames producNameList) {
    isUpdate(true);

    printInfo(info: "Update ID  ${producNameList.id}");

    productNameText.text = producNameList.productName!;
    productDescriptionText.text = producNameList.description!;
    productPriceText.text = producNameList.price.toString();
    offerTextEditingController.text =
        producNameList.offer_amount == null ? "0" : producNameList.offer_amount.toString();
    imageUrl(producNameList.imagePath!);
    selectedProductCategory.value =
        productCategoryList.elementAt(productCategoryList.indexWhere((element) {
      printInfo(
          info:
              "Updated ${element.id.toString()}   ${producNameList.productTypeId.toString()}");

      return element.id
          .toString()
          .endsWith(producNameList.productTypeId.toString());
    }));
    imageUrl.value = producNameList.imagePath!;
  }

  Future updateInformation(BuildContext context) async {
    String _file = File(productSelectedImage.value.path).path;

    Either<dynamic, Failure>? response;
    if (addNewProductFormValidation()) {
      print("Update...................");
      print("p name : " + productNameText.text);
      print("p code : " + productCodeText.text);
      print("p type id : " + selectedProductCategory.value!.id.toString());
      print("Image File : " + _file);

      loading(true);
      response = await vendorRemoteRepository.updateProductInformation(
          selectedProductName.value.id,
          productNameText.text,
          "code",
          productDescriptionText.text,
          selectedProductCategory.value!.id,
          productPriceText.text,
          "imagePath",
          imageUrl.value,
          "1",
          offerTextEditingController.value.text,
          File(productSelectedImage.value.path));

      //print("update is ${response}");

      response.fold((l) {
        print('product update  ok ${l}  ');
        loading(false);

        if (l[AppConstant.success].toString() == 'true') {
          AppSnackBar.successSnackbar(msg: "Product successfully Updated ");
          clearAllRequiredField();
          getProductNames();

          Navigator.pop(context);
        } else {
          loading(false);
          AppSnackBar.errorSnackbar(
              msg: l.toString().replaceAll("{", "").replaceAll("}", ""));
        }
      }, (r) {
        loading(false);

        //  AppSnackBar.errorSnackbar(msg: '${r.toString()}');
      });
    }

    return response;
  }

  void clearCache() {
    offerTextEditingController.clear();
  }

/* void _getProductTypeList() async {
    productCategoryList.value = await getProductCategoryList();
  }*/
}
