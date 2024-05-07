//Screen

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/new_order_model.dart';
import 'package:single_vendor_admin/data/repository/Repositories/OrderRepository.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstant.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';

class ProcessingOrderController extends GetxController {
  static ProcessingOrderController to = Get.find();
  OrderRepository _orderRepository = new OrderRepository();

  List<Orders> orderList = <Orders>[];
  RxBool dataLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getProcessingOrders() async {
    dataLoading.value = true;
    Either<dynamic, Failure> response = await (_orderRepository.pendingOrder() as FutureOr<Either<dynamic, Failure>>);

    response.fold((l) {
      print("Left ===>  ${l['status_code']}");

      if (l[AppConstant.success].toString() == 'true' &&
          l['status_code'].toString() == '200') {
        orderList = (l['message'] as List)
            .map((itemWord) => Orders.fromJson(itemWord))
            .toList();
        print('-------------- all orders ${orderList}');
        dataLoading.value = false;
      } else {
        dataLoading.value = true;
        AppSnackBar.errorSnackbar(msg: "You have not ordered yet!");
      }
    }, (r) {
      print("Right ${r}");
    });
    // response.fold((l) {
    //
    //   print("Left ===>  ${l['status_code']}");
    //
    //   if (l[AppConstant.success].toString() == 'true' && l['status_code'].toString() == '200' ) {
    //
    //    // orderList = (l['message'] as List).map((itemWord) => Orders.fromJson(itemWord)).toList();
    //     print('all completed orders ${orderList}');
    //     dataLoading.value = false;
    //   }else {
    //     dataLoading.value = true;
    //     AppSnackBar.errorSnackbar(msg: l['message']);
    //   }
    // }, (r) {
    //   print("Right ${r}");
    // });
  }
}
