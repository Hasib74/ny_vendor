import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/data/model/delivery_man.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/CookingItems/Controller/CookingItemsController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

class AssignToDeliveryManScreen extends StatelessWidget {
  int? orderId;

  AssignToDeliveryManScreen({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: Get.width * 0.95,
          height: Get.height * 0.95,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              AppSpaces.spaces_height_15,
              Row(
                children: [
                  AppSpaces.spaces_width_15,
                  Text(
                    "Assign To Delivery Man",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                  AppSpaces.spaces_width_10,
                ],
              ),
              AppSpaces.spaces_height_15,
              Expanded(
                child: FutureBuilder(
                  future: CookingItemsController.to.getDeliveryMan(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DeliveryMan?> deliveryMan) {
                    if (deliveryMan.hasData == false ||
                        deliveryMan.data == null) {
                      return Center(
                        child: AppLoading(),
                      );
                    } else {
                      if (deliveryMan.data!.message!.isEmpty) {
                        return Center(
                          child: Text("Empty"),
                        );
                      }

                      return ListView.separated(
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          itemBuilder: (context, int index) {
                            var _deliveryMan = deliveryMan.data!.message![index];

                            return ListTile(
                              title: Text(
                                _deliveryMan.fullName!,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(_deliveryMan.email! +
                                  "\n" +
                                  _deliveryMan.phone!),
                              // leading: CircleAvatar(
                              //   radius: 40.0,
                              //   backgroundImage: NetworkImage(
                              //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5-hU8YSevjwus3PZBoiGXn3kHicUZ60ldt4ML33vx&s",
                              //   ),
                              //   backgroundColor: Colors.transparent,
                              // ),
                              trailing: Obx(() {
                                if (CookingItemsController
                                        .to.assignNowLoading.value &&
                                    CookingItemsController.to.loadingId !=
                                        null &&
                                    CookingItemsController.to.loadingId ==
                                        _deliveryMan.deliveryMenId) {
                                  return Container(
                                    width: 100,
                                    child: SpinKitWave(
                                      color: AppColors.orange,
                                      size: 30,
                                    ),
                                  );
                                } else {
                                  return InkWell(
                                    onTap: () async {
                                      await CookingItemsController.to.assignNow(
                                          deliveryManId:
                                              _deliveryMan.deliveryMenId,
                                          orderId : orderId);

                                      Navigator.pop(context, true);
                                    },
                                    child: Text(
                                      "Assign now",
                                      style: TextStyle(
                                          color: AppColors.orange,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }
                              }),
                            );
                          },
                          separatorBuilder: (context, int index) {
                            return Column(
                              children: [
                                AppSpaces.spaces_height_15,
                                Divider(),
                              ],
                            );
                          },
                          itemCount: deliveryMan.data!.message!.length);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
