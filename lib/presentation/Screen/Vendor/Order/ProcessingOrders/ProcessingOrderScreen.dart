import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/data/model/new_order_model.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/ProcessingOrders/ProcessingOrderController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/Widgets/OrderReportCard.dart';

class ProcessingOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(ProcessingOrderController());
    ProcessingOrderController.to.getProcessingOrders();
    return Scaffold(
        appBar: AppBar(
          title: Text('Processing Orders'),
          backgroundColor: Colors.deepOrange,
        ),
        body: SafeArea(
          child: Obx(
            () => Container(
                padding: EdgeInsets.all(10),
                width: Get.width,
                height: Get.height,
                color: Colors.white,
                child: ProcessingOrderController.to.dataLoading == true
                    ? Center(
                        child: AppLoading(),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await ProcessingOrderController.to
                              .getProcessingOrders();
                        },
                        child: ListView.builder(
                          itemCount:
                              ProcessingOrderController.to.orderList.length,
                          itemBuilder: (context, int index) {
                            Orders anOrder =
                                ProcessingOrderController.to.orderList[index];
                            print('order details is ${anOrder.totalAmount}');
                            return OrderReportCard(anOrder: anOrder);
                            /*
                  return Card(

                      child:Container(
                        color: Colors.grey[100],
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Order Date:20-11-2020')
                              ],

                            ),
                            Row(
                              children: <Widget>[
                                Text('Order Amount: 200 TK')
                              ],

                            ),
                            Row(
                              children: <Widget>[
                                Text('Paid By cash/Card')
                              ],

                            ),
                            Row(
                              children: <Widget>[
                                Text('Delivery By nazmul Islam'),
                              ],

                            ),
                            Row(
                              children: <Widget>[
                                Text('Delivery To: Mirpur10,dhaka'),
                              ],

                            ),
                          ],
                        ),
                      )
                  );
                */
                          },
                        ),
                      )),
          ),
        ));
  }
}
