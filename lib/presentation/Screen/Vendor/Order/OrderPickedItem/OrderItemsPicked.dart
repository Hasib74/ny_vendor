import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/place_picker.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/OrderPickedItem/Controller/OrderItemsPickedController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/OrderItemPickedWidget.dart';

import '../../../../Routes/AppsRoutes.dart';
import '../../AssignToDeliveryMan/assign_to_delivery.dart';

class OrderItemsPicked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderItemsPickedController.to.getPickedItems();

    return Scaffold(
        body: Stack(
      children: [
        _body(),
        _loading(),
      ],
    ));
  }

  Obx _body() {
    return Obx(() => Positioned.fill(
          child: OrderItemsPickedController.to.orderPickedModel.value.message ==
                  null
              ? Container()
              : RefreshIndicator(
                  onRefresh: () async {
                    await OrderItemsPickedController.to.getPickedItems();
                  },
                  child: ListView.builder(
                      itemCount: OrderItemsPickedController
                          .to.orderPickedModel.value.message!.length,
                      itemBuilder: (context, int index) {
                        var _data = OrderItemsPickedController
                            .to.orderPickedModel.value.message![index];

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
                            onAccept: () {
                              OrderItemsPickedController.to
                                  .pickedOrderAccept(_data.id, context);

                              //  Get.to(AssignToDelivery());
                            }, pickUpLocation: LatLng(double.parse(_data.latValue?? "0.0"), double.parse(_data.longValue ?? "0.0"))
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
        ));
  }

  _loading() {
    return Obx(() {
      printInfo(
          info:
              "Order picked item --- Loading :: ${OrderItemsPickedController.to.loading.value}");

      return OrderItemsPickedController.to.loading.value
          ? Positioned.fill(
              child: Align(
              alignment: Alignment.center,
              child: AppLoading(),
            ))
          : Container();
    });
  }
}
