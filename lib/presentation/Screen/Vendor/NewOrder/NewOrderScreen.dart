import 'package:flutter/material.dart';
import 'package:single_vendor_admin/data/model/new_order_model.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/NewOrder/Controller/NewOrdersController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/NewOrder/OrderDetails/OrderDetailsScreen.dart';

import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/NewOrderWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:get/get.dart';

import '../AssignToDeliveryMan/assign_to_delivery.dart';

class NewOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(NewOrdersController());
    NewOrdersController.to.getNewOrders();

    return Scaffold(
      appBar: AppBar(
        title: Text('New Order Details'),
        backgroundColor: AppColors.orange,
      ),
      body: SafeArea(
        // child: SingleChildScrollView(
        child: Obx(
          () => Container(
            width: Get.width,
            height: Get.height,
            child: NewOrdersController.to.dataLoading == true
                ? Center(
                    child: AppLoading(),
                  )
                : ListView.builder(
                    itemCount: NewOrdersController.to.orderList.length,
                    itemBuilder: (context, int index) {
                      Orders _order = NewOrdersController.to.orderList[index];

                      return NewOrderWidget(
                          anewOrder: _order,
                          accept: () {
                            print("accept api is call");
                            NewOrdersController.to
                                .orderItemsDeliveryToDeliveryMan(_order.id);

                            //   Get.to(AssignToDelivery());
                          },
                          decline: () {
                            //  _orderAcceptDelineController.selectedOptionDecline = OrderAcceptOrDelineController.to.newOrder.value.message[index];
                            //  _orderAcceptDelineController.orderDecline();
                            print("decline api is call");
                          },
                          details: () {
                            print('tab on for order details ${_order.id}');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OrderDetailsScreen(
                                      orderId: _order.id,
                                    )));
                          });
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
