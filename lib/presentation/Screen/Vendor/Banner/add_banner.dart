import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Banner/controller/banner_controller.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Banner/model/banner_model.dart'
    as banner_model;
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppTextFieldWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/ImageViewWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../../../core/functions/app_image_picker.dart';

class AddBanner extends StatefulWidget {
  banner_model.Response? bannerModel = banner_model.Response();

  AddBanner({Key? key, this.bannerModel}) : super(key: key);

  @override
  State<AddBanner> createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBanner> {
  String? imageUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.bannerModel != null) {
      BannerController.to.bannerNameController.text = widget.bannerModel!.name!;

      imageUrl = widget.bannerModel!.image!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSpaces.spaces_height_10,
              AppSpaces.spaces_height_10,
              AppSpaces.spaces_height_10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    "       Add Banner",
                    style: Get.textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpaces.spaces_height_15,
              AppSpaces.spaces_height_15,
              _image(context),
              AppSpaces.spaces_height_15,
              AppSpaces.spaces_height_15,
              AppTextFieldWidget(
                controller: BannerController.to.bannerNameController,
                hint: "Banner Name",
              ),
              AppSpaces.spaces_height_15,
              AppSpaces.spaces_height_15,
              AppButtonWidget(
                  title: "Upload Banner",
                  leadingCenter: true,
                  onTab: () {
                    if (widget.bannerModel != null) {
                      BannerController.to
                          .updateBanner(context, widget.bannerModel!.id! , imageUrl);
                    } else {
                      BannerController.to.createBanner(context);
                    }
                  }),
              AppSpaces.spaces_height_15,
              AppSpaces.spaces_height_15,
            ],
          ),
          Obx(() => BannerController.to.isLoading.value
              ? Center(
                  child: AppLoading(),
                )
              : Container()),
        ],
      ),
    );
  }

  _image(BuildContext context) {
    return Obx(() {
      if (BannerController.to.bannerImage.value.path.isEmpty) {
        return InkWell(
          onTap: () async {
            XFile? _image = await openGalleryOrCameraAndPickImage(context);
            print(_image?.path);
            BannerController.to.bannerImage(_image);
          },
          child: imageUrl != null
              ? ImageViewWidget(
                  imageUrl: URL.host_url + imageUrl!,
                  height: 180,
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.cover,
                  imageType: ImageType.RECTANGLE,
                )
              : DottedBorder(
                  radius: Radius.circular(10),
                  child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.add), Text("Add Banner")],
                    ),
                  ),
                ),
        );
      } else {
        return ImageViewWidget(
          file: File(BannerController.to.bannerImage.value.path),
          height: 180,
          width: MediaQuery.of(context).size.width * 0.9,
          fit: BoxFit.cover,
          imageType: ImageType.RECTANGLE,
        );
      }
    });
  }
}
