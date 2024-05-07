import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:single_vendor_admin/data/model/ProductTypeModel.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProducts/Controller/AddProductController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/ImageViewWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:single_vendor_admin/presentation/utils/Dimension.dart';

import '../../../../main.dart';

class AddProductDialog extends StatefulWidget {
  AddProductDialog({Key? key}) : super(key: key);

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  late BuildContext context;

  bool? isSave;

  String? image_url;

  List<String> offerType = ["%", ];

  @override
  void dispose() {
    // TODO: implement dispose

    AddProductController.to.productSelectedImage.value = XFile("");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    AddProductController.to.selectedDropDownMenu.value = offerType[0];

    isSave = Get.arguments["isSave"];

    image_url = Get.arguments["image_url"];

    print("Argument Is save ::: ${isSave}");
    print("Argument Is save ::: ${image_url}");

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _body(),
            _loading(),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Add Product",
                    style: Get.textTheme.headline5!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Icon(
                        Icons.clear,
                        size: 22,
                        color: Colors.black,
                      ),
                    )),
              ],
            ),
          ),
          AppSpaces.spaces_height_25,
          _productType(),
          AppSpaces.spaces_height_15,
          _productName(),
          AppSpaces.spaces_height_15,
          _description(),
          AppSpaces.spaces_height_15,
          _addOffer(),
          AppSpaces.spaces_height_15,
          _photo_and_price(),
          _save_bar(),
        ],
      ),
    );
  }

  Row _productType() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
            leadingCenter: true,
            horizontal_padding: 0,
            width: Dimension.vendor_sign_up_text_with_icon_button_width,
            height: 45,
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.product_type,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        AddProductController.to.productCategoryList.value == null
            ? Container()
            : Expanded(child: Obx(() {
                return DropdownButton<ProductTypeModel>(
                  hint: Text("Select Product Category"),
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  underline: SizedBox(),
                  isExpanded: true,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  value: AddProductController
                              .to.selectedProductCategory.value!.id !=
                          null
                      ? AddProductController.to.selectedProductCategory.value
                      : null,
                  // value: "ttt", /* AddProductController.to.selectedProductCategory.value*/
                  onChanged: (newProductType) {
                    //   print("newProductType  ${newProductType.id}");

                    //   setState(() {
                    //  selectedProductType = newProductType;
                    AddProductController.to.selectedProductCategory.value =
                        newProductType;
                    // });
                  },
                  items: AddProductController.to.productCategoryList.value
                      .map((ProductTypeModel aproductType) {
                    print("ProductTypeModel  ${aproductType.id}");
                    return DropdownMenuItem(
                      value: aproductType,
                      child: Text(aproductType.productTypeName ?? ""),
                    );
                  }).toList(),
                );
              })),
        AppSpaces.spaces_width_15,
      ],
    );
  }

  Row _productName() {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
            leadingCenter: true,
            horizontal_padding: 0,
            width: Dimension.vendor_sign_up_text_with_icon_button_width,
            height: 45,
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.product_name,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: AppTextFieldWidget(
                maxLength: 30,
                maxLines: 1,
                padding: 0,
                padding_right: 16,
                controller: AddProductController.to.productNameText)),
      ],
    );
  }

  _description() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        AppButtonWidget(
            backgroundColor: AppColors.orange,
            leadingCenter: true,
            horizontal_padding: 0,
            width: Dimension.vendor_sign_up_text_with_icon_button_width,
            height: 45,
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            //   icon: Icons.location_on,
            title: language.description,
            iconColor: Colors.white),
        AppSpaces.spaces_width_10,
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: AppTextFieldWidget(
              textInputType: TextInputType.multiline,
              maxLines: 5,
              padding: 0,
              controller: AddProductController.to.productDescriptionText,
              height: 200),
        )),
      ],
    );
  }

  _photo_and_price() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        Column(
          children: [
            AppButtonWidget(
                backgroundColor: AppColors.orange,
                leadingCenter: true,
                horizontal_padding: 0,
                width: Dimension.vendor_sign_up_text_with_icon_button_width,
                height: 45,
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
                //   icon: Icons.location_on,
                title: language.price,
                iconColor: Colors.white),
            AppSpaces.spaces_height_15,
            AppButtonWidget(
                backgroundColor: AppColors.orange,
                leadingCenter: true,
                horizontal_padding: 0,
                width: Dimension.vendor_sign_up_text_with_icon_button_width,
                height: 45,
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
                //   icon: Icons.location_on,
                title: language.photo,
                iconColor: Colors.white),
          ],
        ),
        AppSpaces.spaces_width_10,
        Expanded(
          child: Column(
            children: [
              AppTextFieldWidget(
                  padding: 0,
                  padding_right: 16,
                  controller: AddProductController.to.productPriceText,
                  textInputType: TextInputType.number),
              AppSpaces.spaces_height_15,
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: AppButtonWidget(
                    backgroundColor: AppColors.text_fileld_color,
                    leadingCenter: true,
                    horizontal_padding: 0,
                    width: Dimension.vendor_sign_up_text_with_icon_button_width,
                    height: 45,
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    //   icon: Icons.location_on,
                    title: language.upload,
                    onTab: () {
                      showProductImageSelectSource();
                    },
                    iconColor: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            print("Image url .... ${image_url}");
            if (!isSave!) {
              if (AddProductController.to.productSelectedImage.value !=
                  XFile("")) {
                return Container(
                    child: AddProductController.to.productSelectedImage.value ==
                            XFile("")
                        ? ImageViewWidget(
                            imageUrl:
                                AddProductController.to.productDemoImagePath)
                        : ImageViewWidget(
                            file: File(AddProductController
                                .to.productSelectedImage.value.path),
                            imageUrl: '',
                          ));
              } else {
                return ImageViewWidget(imageUrl: image_url);
              }
            } else {
              return Container(
                  child: AddProductController.to.productSelectedImage.value ==
                          XFile("")
                      ? ImageViewWidget(
                          imageUrl:
                              AddProductController.to.productDemoImagePath)
                      : ImageViewWidget(
                          file: File(AddProductController
                              .to.productSelectedImage.value.path),
                          imageUrl: ''));
            }

            /*   if (AddProductController.to.imageUrl.value.isNotEmpty) {
              return ImageViewWidget(
                  imageUrl: AddProductController.to.imageUrl.value);
            } else {
              return Container(
                  child: AddProductController.to.productSelectedImage.value ==
                          XFile("")
                      ? ImageViewWidget(
                          imageUrl:
                              AddProductController.to.productDemoImagePath)
                      : ImageViewWidget(
                          file: File(AddProductController
                              .to.productSelectedImage.value.path),
                          imageUrl: ''));
            }*/
          }),
        ),
        AppSpaces.spaces_width_15,
      ],
    );
  }

  _save_bar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: Colors.grey,
            ),
          ),
          AppSpaces.spaces_width_25,
          AppButtonWidget(
              title: !isSave! ? "Update" : language.save,
              width: 80,
              leadingCenter: true,
              onTab: () async {
                printInfo(info: "Loading ..............1 ${isSave}");
                if (!isSave!) {
                  print("Start Updating");
                  await AddProductController.to.updateInformation(context);
                } else {
                  print("Start Saving");
                  AddProductController.to.saveNewProductInformation(context);
                }
                //Get.back();
                //_addProductController.getProductNames();
              }),
        ],
      ),
    );
  }

  Future<void> showProductImageSelectSource() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Select Product Image ')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[],
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Icon(Icons.photo_album), // Text('Open Gallery'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.deepOrange,
                  onSurface: Colors.grey,
                  shadowColor: Colors.red,
                  elevation: 5,
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),
                onPressed: () {
                  openPhoneCameraOrGallery(false);
                },
              ),
            ),
            SizedBox(height: 7),
            Center(
              child: TextButton(
                child: Icon(Icons.camera_alt), // Text('Open Camera'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.deepOrange,
                  onSurface: Colors.grey,
                  shadowColor: Colors.red,
                  elevation: 5,
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),
                onPressed: () {
                  openPhoneCameraOrGallery(true);
                },
              ),
            ),
          ],
        );
      },
    );
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
      AddProductController.to.productImageUIUpdate();
      Get.back();
      print('photo ok');
    } else {
      print('No image selected.');
    }
  }

  _loading() {
    return Obx(() {
      print(
          "Loading ................  ${AddProductController.to.loading.value}");

      return AddProductController.to.loading.value
          ? Align(
              alignment: Alignment.center,
              child: AppLoading(),
            )
          : Container();
    });
  }

  _addOffer() {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Row(
        children: [
          AppSpaces.spaces_width_10,
          AppButtonWidget(
              backgroundColor: AppColors.orange,
              leadingCenter: true,
              horizontal_padding: 0,
              width: Dimension.vendor_sign_up_text_with_icon_button_width,
              height: 45,
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
              //   icon: Icons.location_on,
              title: "Offer",
              iconColor: AppColors.orange),
          AppSpaces.spaces_width_15,
          Obx(() => Expanded(
              child: AppTextFieldWidget(
                  isDropDown: true,
                  dropDownMenus: offerType,
                  selectedDropDownMenu:
                      AddProductController.to.selectedDropDownMenu.value,
                  selectedDropDownMenuFn: (value) {
                    printInfo(info: "Selected dropdown menu : ${value}");
                    AddProductController.to.selectedDropDownMenu.value = value!;
                  },
                  selectedDropDownValue:
                      AddProductController.to.selectedDropDownMenu.value,
                  padding: 0,
                  padding_right: 16,
                  textInputType: TextInputType.number,
                  controller:
                      AddProductController.to.offerTextEditingController))),
        ],
      ),
    );
  }
}
