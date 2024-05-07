//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:single_vendor_admin/data/model/ProductNameModel.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';
import 'package:single_vendor_admin/presentation/Routes/AppsRoutes.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProductType/Controller/AddProductTypeController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProducts/Controller/AddProductController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/ProductCard.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';

import '../../../Widgets/SearchWidget.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  //late SearchBar searchBar;

  final imagePicker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(AddProductController());

    AddProductController.to.getProductCategoryList();
    AddProductController.to.getProductNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: searchBar.build(context),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange,
        onPressed: () {
          Get.toNamed(AppRoutes.ADD_PRODUCT_DIALOG,
              arguments: {"isSave": true});
        },
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() => AbsorbPointer(
            absorbing: AddProductController.to.loading.value,
            child: SingleChildScrollView(
              child: Stack(
                children: [_body(), _loading()],
              ),
            ),
          )),
    );
  }

  _loading() {
    return Obx(() => AddProductController.to.loading.value
        ? Positioned.fill(
            child: Align(
            alignment: Alignment.center,
            child: AppLoading(),
          ))
        : Container());
  }

  _body() {
    return Obx(() {
      if (AddProductController.to.producNameList.value == null) {
        return AppLoading();
      } else {
        return Container(
          height: Get.height - Get.statusBarHeight,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchBar(),
              if (AddProductController.to.searchListProducts.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "Search Result: ${AddProductController.to.searchListProducts.length}",
                    style: Get.textTheme.bodyText1,
                  ),
                ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    shrinkWrap: true,
                    itemCount: AddProductController
                                .to.searchListProducts.value.length ==
                            0
                        ? AddProductController.to.producNameList.value.length
                        : AddProductController
                            .to.searchListProducts.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (AddProductController.to.producNameList.value ==
                          null) {
                        return AppLoading();
                      } else {
                        var _product = AddProductController
                                .to.searchListProducts.isNotEmpty
                            ? AddProductController.to.searchListProducts[index]
                            : AddProductController.to.producNameList[index];
                        return ProductCard(
                            productType: _type(_product),
                            stock: _product.quantity.toString(),
                            productName: _product.productName,
                            price: _product.price.toString(),
                            image: URL.host_url + _product.imagePath.toString(),
                            description: _product.description,
                            offerAmount:
                                "Offer: ${_product.offer_amount == null ? "0 %" : _product.offer_amount.toString() + " %"}",
                            /*     stock: AddProductController
                              .to.producNameList[index],*/
                            delete: () {
                              // AddProductController.to.loading(true);
                              AddProductController
                                  .to.selectedProductName.value = _product;
                              print("Delete is called ${_product.productName}");
                              showProdutDeleteAlert(context);
                            },
                            edit: () {
                              AddProductController
                                  .to.selectedProductName.value = _product;

                              AddProductController.to.searchListProducts
                                  .clear();

                              AddProductController
                                  .to.searchTextEditingController
                                  .clear();

                              AddProductController.to.setUpUpdate(_product);
                              Get.toNamed(AppRoutes.ADD_PRODUCT_DIALOG,
                                  arguments: {
                                    "isSave": false,
                                    "image_url": URL.host_url +
                                        AddProductController
                                            .to.producNameList[index].imagePath
                                            .toString()
                                  });
                            },
                            addStock: () {
                              AddProductController
                                  .to.selectedProductName.value = _product;
                              /* print(
                                "add stock is called ${AddProductController.to.productsAllInformation.value.products[index]}");*/
                              showAlertDialogWithTextEditingField(context)
                                  .then((value) {
                                AddProductController.to.searchListProducts
                                    .clear();
                                AddProductController
                                    .to.searchTextEditingController
                                    .clear();
                              });
                            });
                      }
                    }),
              )
            ],
          ),
        );
      }
    });
  }

  Future openPhoneCameraOrGallery(bool isCamera) async {
    // final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    final imagePicker = ImagePicker();

    XFile? pickedFile;
    if (isCamera) {
      pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    }
    if (pickedFile != null) {
      AddProductController.to.productSelectedImage.value = pickedFile;

      Get.back();
      print('photo ok');
    } else {
      print('No image selected.');
    }
  }

  /*
    =====================================================================
    ======================== PRODUCT STOP UPDATE=================
    =====================================================================
  */
  Future<void> showAlertDialogWithTextEditingField(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        AddProductController.to.productStockTextField.text = "";
        return AlertDialog(
          title: Text('Product Stock'),
          content: TextField(
            controller: AddProductController.to.productStockTextField,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Enter Stock Quantity"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Update Stock'),
              onPressed: () {
                print(AddProductController.to.productStockTextField.text);
                AddProductController.to.updateProductStock(
                    AddProductController.to.selectedProductName.value.id);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Add To Srtock'),
              onPressed: () {
                print(AddProductController.to.productStockTextField.text);
                AddProductController.to.addProductStock(
                    AddProductController.to.selectedProductName.value.id);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'CANCEL',
                style: Get.textTheme.bodyText2!.copyWith(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  /*
    =====================================================================
    ======================== PRODUCT INFO EDIT OR DELETE=================
    =====================================================================
  */

  showProdutDeleteAlert(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text(
        "Yes",
        textAlign: TextAlign.left,
      ),
      onPressed: () {
        if (AddProductController.to.selectedProductName.value != null) {
          Navigator.of(context).pop();
          // productTypeController.
          // = language.save;
          AddProductController.to.deleteASelectedProductName(
              AddProductController.to.selectedProductName.value.id);

          AddProductController.to.searchTextEditingController.clear();
        }
      },
    );

    Widget cancelButton = TextButton(
      child: Text('No'),
      onPressed: () {
        print('No button press');
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text("Warning")),
      content: Text("Do You want to Delete?"),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _type(ProductNames _product) {
    print("ProductNames type id :: ${_product.productTypeId}");
    print("ProductNames type id :: ${_product.productName}");
    print("======================================");
    ProductTypeController.to.productTypeList.forEach((element) {
      print("element type id :: ${element.id}");
      print("element type providerId :: ${element.providerId}");
      print("element type serviceTypeId :: ${element.serviceTypeId}");
    });

    try {
      // print(
      //     "Product type name :::  ${ProductTypeController.to.productTypeList.singleWhere((element) => element.serviceTypeId == _product.productTypeId).productTypeName}");
      return ProductTypeController.to.productTypeList
          .where((e) => e.id == _product.productTypeId)
          .last
          .productTypeName;

      return "Test name";
    } catch (err) {
      printInfo(info: "Product type name ::: Error ${err}");

      return "";
    }
  }

  //aapbar
  // AppBar buildAppBar(BuildContext context) {
  //   return new AppBar(
  //       title: new Text('Products'),
  //       actions: [searchBar.getSearchAction(context)]);
  // }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 8),
      child: AppSearchWidget(
        searchTextController:
            AddProductController.to.searchTextEditingController,
        searchText: (value) {
          if (value.isNotEmpty) {
            AddProductController.to.getProductsBySearch(search: value);
          } else {
            AddProductController.to.searchListProducts.clear();
            AddProductController.to.searchListProducts.refresh();
          }
        },
        closeBtnOnClick: () {
          AddProductController.to.searchTextEditingController.clear();
          AddProductController.to.searchListProducts.clear();
        },
      ),
    );
  }
}
