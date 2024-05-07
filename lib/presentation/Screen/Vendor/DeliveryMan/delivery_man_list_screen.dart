import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/DeliveryMan/Controller/delivery_man_controller.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/DeliveryMan/add_delivery_man.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppButtonWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/ImageViewWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

import '../../../../data/model/delivery_man.dart';
import '../../../../data/repository/remote/DataSource/URL.dart';
import '../../../Routes/AppsRoutes.dart';

class DeliveryManScreen extends StatefulWidget {
  const DeliveryManScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryManScreen> createState() => _DeliveryManScreenState();
}

class _DeliveryManScreenState extends State<DeliveryManScreen> {
  @override
  initState() {
    super.initState();
    AppDeliveryManController.to.getDeliveryMan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              AppSpaces.spaces_height_20,
              AppButtonWidget(
                onTab: () async {
                  print("Tabbbb");
                  bool? canLoad = await Get.to(AddDeliveryManScreen());

                  if (canLoad != null && canLoad == true) {
                    setState(() {});
                  }
                },
                leadingCenter: true,
                title: "Add Delivery Man",
              ),
              Expanded(
                child: _deliveryManList(),
              ),
            ],
          ),
          Obx(() => AppDeliveryManController.to.isLoading.value
              ? Center(child: AppLoading())
              : Container()),
        ],
      ),
    );
  }

  _deliveryManList() {
    return Obx(() {
      if (AppDeliveryManController.to.deliveryMan.value?.message == null) {
        return Center(
          child: AppLoading(),
        );
      } else {
        if (AppDeliveryManController.to.deliveryMan.value!.message!.isEmpty) {
          return Center(
            child: Text("Empty"),
          );
        }

        var _data = AppDeliveryManController.to.deliveryMan.value!.message;
        return ListView.separated(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          itemCount: _data!.length,
          itemBuilder: (context, index) {
            var _deliveryMan = _data[index];

            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: PhysicalModel(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                shadowColor: Colors.grey,
                color: Colors.grey,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppSpaces.spaces_width_20,
                      ProfilePicture(
                        name: _deliveryMan.fullName!,
                        radius: 31,
                        fontsize: 21,
                        img: _deliveryMan.image != null
                            ? URL.host_url + _deliveryMan.image!
                            : null,
                      ),
                      AppSpaces.spaces_width_20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSpaces.spaces_height_15,
                          Text(
                            _deliveryMan.fullName!,
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          AppSpaces.spaces_height_10,
                          Text(
                            _deliveryMan.email!,
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          AppSpaces.spaces_height_10,
                          Text(
                            _deliveryMan.phone!,
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          // AppSpaces.spaces_height_10,
                          // Container(
                          //   height: 20,
                          //   width: 60,
                          //   decoration: BoxDecoration(
                          //       color: index % 2 == 0
                          //           ? Colors.green
                          //           : Colors.red,
                          //       borderRadius: BorderRadius.circular(10)),
                          //   child: Center(
                          //     child: Text(
                          //       index % 2 == 0 ? "Active" : "Online",
                          //       style: TextStyle(
                          //           color: AppColors.white,
                          //           fontSize: 12,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // ),
                          AppSpaces.spaces_height_15,
                          Row(
                            children: [
                              // InkWell(
                              //   onTap: () {
                              //
                              //     Get.to(new AddDeliveryManScreen(
                              //       isEdit: true,
                              //       editEmail: _deliveryMan.email,
                              //       editFullName: _deliveryMan.fullName,
                              //       editPhoneNUmber: _deliveryMan.phone,
                              //
                              //     ));
                              //   },
                              //   child: Text(
                              //     "Edit",
                              //     style: TextStyle(
                              //         color: AppColors.green,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.bold),
                              //   ),
                              // ),
                              // AppSpaces.spaces_width_15,
                              // Container(
                              //   width: 2,
                              //   height: 15,
                              //   color: AppColors.black,
                              // ),
                             // AppSpaces.spaces_width_15,
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Stack(
                                          children: [
                                            AlertDialog(
                                              title: Text("Delete"),
                                              content: Text("Are you sure?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("No")),
                                                TextButton(
                                                    onPressed: () async {
                                                      bool? canLoad =
                                                          await AppDeliveryManController
                                                              .to
                                                              .deleteDeliveryMan(
                                                                  _deliveryMan
                                                                      .deliveryMenId
                                                                      .toString());
                                                      if (canLoad) {
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: Text("Yes")),
                                              ],
                                            ),
                                            Obx(() => AppDeliveryManController
                                                    .to.isLoading.value
                                                ? Center(child: AppLoading())
                                                : Container()),
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          AppSpaces.spaces_height_15,
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return AppSpaces.spaces_height_15;
          },
        );
      }
    });
  }
}
