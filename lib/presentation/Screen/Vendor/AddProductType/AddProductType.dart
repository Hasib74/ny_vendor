import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/data/model/ProductTypeModel.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProductType/Controller/AddProductTypeController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProducts/Controller/AddProductController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/ProductTypeWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

import '../../../../data/repository/remote/DataSource/URL.dart';
import '../../../../main.dart';

class AddProductType extends StatefulWidget {
  @override
  State<AddProductType> createState() => _AddProductTypeState();
}

class _AddProductTypeState extends State<AddProductType> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    ProductTypeController.to.loading(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.put(ProductTypeController());

    ProductTypeController.to.loading(false);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ProductTypeController());

    print("Vendor  VALUE${ProfileController.to.vendorModel.value.id}");

    if (ProfileController.to.vendorModel.value.id != null) {
      //   ProductTypeController.to.loading(true);

      print("Vendor ID IS ${ProfileController.to.vendorModel.value.id}");

      Future.delayed(Duration(seconds: 0)).then((value) {
        print("Vendor ID IS 11 ${ProfileController.to.vendorModel.value.id}");

        if (ProfileController.to.vendorModel.value.id != null) {
          ProductTypeController.to.updateProductTypeListWithUI();
          ProductTypeController.to.loading(false);
        }
      });
    } else {
      Future.delayed(Duration(seconds: 1)).then((value) {
        print("Vendor ID IS ${ProfileController.to.vendorModel.value.id}");

        if (ProfileController.to.vendorModel.value.id != null) {
          ProductTypeController.to.updateProductTypeListWithUI();
          ProductTypeController.to.loading(false);
        }
      });
    }

    Future.delayed(Duration(seconds: 2)).then((value) {
      ProductTypeController.to.updateProductTypeListWithUI();
    });

    return Obx(() => AbsorbPointer(
          absorbing: ProductTypeController.to.loading.value,
          child: Container(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                _body(),
                _loading(),
              ],
            ),
          ),
        ));
  }

  _body() {
    return Positioned.fill(
      child: Column(
        children: [
          AppSpaces.spaces_height_25,
          _vendorServiceName(),
          AppSpaces.spaces_height_15,
          _productType(),
          _save_bar(),
          _your_produt_list_text(),
          _product_list(),
        ],
      ),
    );
  }

  Row _vendorServiceName() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // AppSpaces.spaces_width_10 ,

        AppButtonWidget(
            backgroundColor: AppColors.orange,
            leadingCenter: true,
            horizontal_padding: 16,
            height: 45,
            width: Get.width / 1.3,
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: 'Your Selected Service is FOOD',
            // language.Vendor_Service_Name,
            iconColor: Colors.white),

        //   AppSpaces.spaces_width_10 ,

        //   AppSpaces.spaces_width_10,
        // Expanded(child: AppTextFieldWidget(levelText:"Selected Service FOOD",enable: false, padding: 0, padding_right: 16)),
      ],
    );
  }

  Row _productType() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        Expanded(
            flex: 2,
            child: AppButtonWidget(
                backgroundColor: Colors.white,
                leadingCenter: true,
                horizontal_padding: 0,
                // width: 140,
                // Dimension.vendor_sign_up_text_with_icon_button_width,
                height: 45,
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
                //   icon: Icons.location_on,
                title: language.product_type,
                iconColor: Colors.white)),
        AppSpaces.spaces_width_10,
        Expanded(
            flex: 2,
            child: AppTextFieldWidget(
                // maxLines: 1,
                maxLength: 30,
                padding: 0,
                controller: ProductTypeController.to.productTypeText,
                padding_right: 16)),
        _uploadProductTypeImages(),
        AppSpaces.spaces_width_10,
      ],
    );
  }

  Expanded _uploadProductTypeImages() {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          ProductTypeController.to
              .selectProductTypeImageFromGallery();
        },
        child: Obx(() => ProductTypeController
                .to.productTypeImage.value.path.isEmpty
            ? ProductTypeController.to.shouldUpdateProductTypeImage!.value.isEmpty
                ? DottedBorder(
                    child: Container(
                      height: 35,
                      child: Center(
                        child:Icon(
                          Icons.photo,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 45,
                    width: 60,
                    child: Image.network(
                      URL.host_url +
                          ProductTypeController
                              .to.shouldUpdateProductTypeImage!.value,
                      fit: BoxFit.cover,
                    ),
                  )
            : Container(
                height: 45,
                width: 60,
                child: Image.file(
                  File(ProductTypeController.to.productTypeImage.value.path),
                  fit: BoxFit.cover,
                ),
              )),
      ),
    );
  }

  _save_bar() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey,
              ),
            ),
            AppSpaces.spaces_width_25,
            AppButtonWidget(
                title: ProductTypeController.to.saveButtonTitle.value,
                titleColor: Colors.black,
                width: 80,
                leadingCenter: true,
                onTab: () async {
                  ProductTypeController.to.loading(true);
                  await ProductTypeController.to.addNewProductType();
                  ProductTypeController.to.loading(false);
                }),
          ],
        ),
      ),
    );
  }

  _your_produt_list_text() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            language.your_product_list,
            style: Get.textTheme.headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: Get.width / 2.5,
              )
            ],
          ),
        ],
      ),
    );
  }

  _product_list() {
    return Expanded(
      child: Obx(() {
        printInfo(
            info:
                "Products ::: ${ProductTypeController.to.productTypeList.value}");
        return ListView.builder(
            padding: EdgeInsets.only(bottom: 60),
            itemCount: ProductTypeController.to.productTypeList.value.length,
            //physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              printInfo(
                  info:
                      "Products info ::: ${ProductTypeController.to.productTypeList.value[0].productTypeName}");

              String? _remoteImage = ProductTypeController
                  .to.productTypeList.value[index].productTypeImage;

              return ProductTypeWidget(
                  productTypeImage:
                      _remoteImage != null ? URL.host_url + _remoteImage : '',
                  productName: ProductTypeController
                      .to.productTypeList.value[index].productTypeName,
                  productType: '',
                  delete: () {
                    showAlertDialog(context,
                        ProductTypeController.to.productTypeList.value[index]);
                  },
                  edit: () {
                    ProductTypeController.to.selectedProductType.value =
                        ProductTypeController.to.productTypeList.value[index];

                    print(
                        "Edit is called ${ProductTypeController.to.selectedProductType.value!.id}");
                    ProductTypeController.to.saveButtonTitle.value = "Update";
                    ProductTypeController.to.openProductTypeForEditing();

                    ProductTypeController.to.shouldUpdateProductTypeImage
                        ?.value = _remoteImage ?? "";
                  });
            });
      }),
    );
  }

/*
    =====================================================================
    ======================== PRODUCT TYPE EDIT OR DELETE=================
    =====================================================================
  */
  showAlertDialog(BuildContext context, ProductTypeModel value) {
    // Create button
    Widget okButton = TextButton(
      child: Text(
        "Yes",
        textAlign: TextAlign.left,
      ),
      onPressed: () {
        ProductTypeController.to.selectedProductType.value = value;

        print(
            "Delete is called for  ${ProductTypeController.to.selectedProductType.value!.id}");

        if (ProductTypeController.to.selectedProductType != null) {
          Navigator.of(context).pop();
          ProductTypeController.to.saveButtonTitle.value = language.save;
          ProductTypeController.to.deleteAProductType(
              ProductTypeController.to.selectedProductType.value!.id);
        }
      },
    );

    Widget cancelButton = TextButton(
      child: Text('No'),
      onPressed: () {
        print('No button press');
        Navigator.of(context).pop();
        ProductTypeController.to.selectedProductType.value = null;
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text("Warning")),
      content: Text("Do You want to Delete the Product"),
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

  _loading() {
    printInfo(
        info: "Product Type Loading ${ProductTypeController.to.loading.value}");
    return Obx(() => ProductTypeController.to.loading.value
        ? Center(child: AppLoading())
        : Container());
  }
}
