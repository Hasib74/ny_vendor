import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/Complete%20Orders/CompleteOrdersController.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:get/get.dart';

class CompleteOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     Get.put(CompleteOrdersController());
     CompleteOrdersController.to.getCompletedOrders();
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Orders'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Card(
          color: Colors.white,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          borderOnForeground: true,
          elevation: 0,
          margin: EdgeInsets.fromLTRB(0,0,0,0),
          child:Text('Completed orders '),
        )


      ),
    );
  }
}