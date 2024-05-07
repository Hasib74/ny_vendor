import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/place_picker.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/CookingItems/Controller/CookingItemsController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/OrderItemPickedWidget.dart';

import '../../../../Routes/AppsRoutes.dart';
import 'assign_to_delivery_man.dart';

class CookingItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CookingItemsController());

    CookingItemsController.to.getAlreadyAcceptedOrder();

    return Scaffold(
        body: Stack(
      children: [
        _body(),
        _loading(),
      ],
    ));
  }

  Obx _body() {
    return Obx(() {
      printInfo(
          info:
              " CookingItemsController.to.orderAcceptedModel.value.message  : ${CookingItemsController.to.orderAcceptedModel.value.message}");

      return Positioned.fill(
        child: CookingItemsController.to.orderAcceptedModel.value.message ==
                null
            ? Container()
            : RefreshIndicator(
                onRefresh: () async {
                  await CookingItemsController.to.getAlreadyAcceptedOrder();
                },
                child: ListView.builder(
                    itemCount: CookingItemsController
                        .to.orderAcceptedModel.value.message!.length,
                    itemBuilder: (context, int index) {
                      var _data = CookingItemsController
                          .to.orderAcceptedModel.value.message![index];

                      if (_data.customer != null) {
                        String _date = _data.createdAt!.split("T")[0];
                        return OrderItemPickedWidget(
                          date:
                              "${_date.split("-")[2]}/${_date.split("-")[1]}/${_date.split("-")[0]}",
                          time: DateFormat('hh:mm a')
                              .format(DateTime.parse(_data.createdAt!)),
                          productListOnTab: () {
                            Get.toNamed(AppRoutes.ORDER_DETAILS_PRODUCT_LIST,
                                arguments: _data.id);
                          },
                          customer_number: _data.customer!.phone ?? "",
                          customer_address: _data.customer!.address ?? "",
                          customer_name: _data.customer!.fullName ?? "",
                          total_price: _data.totalAmount ?? "",
                          orderId: _data.id,

                          /*       order_items: _data.orderDetails
                                .map((e) =>
                                    "Product Name Id : ${e.orderId}   Quantity : ${e.quantity}")
                                .toList(),
*/
                          buttonName: "Assign to delivery",
                          onAccept: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AssignToDeliveryManScreen(orderId: _data.id,);
                                }).then((value) {
                              CookingItemsController.to
                                  .getAlreadyAcceptedOrder();
                            });
                          }, pickUpLocation:LatLng(0.0 , 0.0),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
      );
    });
  }

  _loading() {
    return Obx(() => CookingItemsController.to.loading.value
        ? Positioned.fill(
            child: Align(
            alignment: Alignment.center,
            child: AppLoading(),
          ))
        : Container());
  }
}
