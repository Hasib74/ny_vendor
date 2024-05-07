import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/place_picker.dart';
import 'package:single_vendor_admin/presentation/Routes/AppsRoutes.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/Ready%20To%20Delivery/Controller/ready_to_delivery_controller.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/OrderItemPickedWidget.dart';

class ReadyToDeliveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(ReadyToDeliveryController());

    ReadyToDeliveryController.to.getReadyToDeliveryItems();

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
          child: ReadyToDeliveryController
                      .to.readyToDeliveryItems.value.message ==
                  null
              ? Container()
              : RefreshIndicator(
                  onRefresh: () async {
                    await ReadyToDeliveryController.to
                        .getReadyToDeliveryItems();
                  },
                  child: ListView.builder(
                      itemCount: ReadyToDeliveryController
                          .to.readyToDeliveryItems.value.message!.length,
                      itemBuilder: (context, int index) {
                        var _data = ReadyToDeliveryController
                            .to.readyToDeliveryItems.value.message![index];

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

                            /* order_items: _data.orderDetails
                                  .map((e) =>
                                      "Product Name Id : ${e.productNameId}   Quantity : ${e.quantity}")
                                  .toList(),*/
                            onAccept: () {
                              ReadyToDeliveryController.to
                                  .deliverOrder(_data.id, context);
                            },
                            buttonName: "Deliver", pickUpLocation: LatLng(double.parse("0.0"), double.parse( "0.0"))
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
        ));
  }

  _loading() {
    return Obx(() => ReadyToDeliveryController.to.loading.value
        ? Positioned.fill(
            child: Align(
            alignment: Alignment.center,
            child: AppLoading(),
          ))
        : Container());
  }
}
