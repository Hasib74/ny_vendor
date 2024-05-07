import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:single_vendor_admin/core/error/failures.dart';

import 'package:single_vendor_admin/data/model/new_order_model.dart';
import 'package:single_vendor_admin/data/repository/Repositories/OrderRepository.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstant.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';
import 'package:get/get.dart';

class NewOrdersController extends GetxController {
  static NewOrdersController to = Get.find();
  OrderRepository _orderRepository = new OrderRepository();

  // RxList<Orders> orderList1 = <Orders>[].obs;
  List<Orders> orderList = <Orders>[];
  RxBool dataLoading = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getNewOrders() async {
    dataLoading.value = true;
    Either<dynamic, Failure> response = await _orderRepository.getNewOrders();
    // newOrder.value = null;
    response.fold((l) {
      //   print("Left ===>  ${l['status_code']}");
      //
      //   if (l[AppConstant.success].toString() == 'true' && l['status_code'].toString() == '200' ) {
      //
      //    orderList = (l['message'] as List).map((itemWord) => Orders.fromJson(itemWord)).toList();
      //     print('all orders ${orderList}');
      //      dataLoading.value = false;
      //   }else {
      //     dataLoading.value = true;
      //     AppSnackBar.errorSnackbar(msg: l['message']);
      //   }
      // }, (r) {
      //   print("Right ${r}");
      // });

      if (l[AppConstant.success].toString() == 'true' &&
          l['status_code'].toString() == '200') {
        orderList = (l['message'] as List)
            .map((item) => Orders.fromJson(item))
            .toList();
        //
        // Map<String,dynamic>  details = l['message'][0];
        // print('=========================  detail orders ${details['customer']}');
        // anOrderDetails.orderDetails  = (details['order_details'] as List<dynamic>).map((anOrderDetails) => OrderDetailsModel.fromjson(anOrderDetails)).toList();
        // anOrderDetails.customer = CustomerModel.fromjson(details['customer']);
        // anOrderDetails.deliveryman =   DeliverymanModel.fromjson(details['delivery_man']);

      } else {
        dataLoading.value = false;
        AppSnackBar.errorSnackbar(msg: "No new order found!");
      }
    }, (r) {
      print("Right ${r}");
    });
  }

  orderItemsDeliveryToDeliveryMan(int? orderId) async {
    dataLoading.value = true;
    Either<dynamic, Failure> response =
        await _orderRepository.orderItemsDeliveryToDeliveryMan(orderId);
    // newOrder.value = null;
    response.fold((l) {
      print("Left ===>  ${l['status_code']}");

      if (l[AppConstant.success].toString() == 'true' &&
          l['status_code'].toString() == '200') {
        AppSnackBar.successSnackbar(msg: l['message']);
        getNewOrders();
      } else {
        dataLoading.value = true;
        AppSnackBar.errorSnackbar(msg: l['message']);
      }
    }, (r) {
      print("Right ${r}");
    });
  }
}
