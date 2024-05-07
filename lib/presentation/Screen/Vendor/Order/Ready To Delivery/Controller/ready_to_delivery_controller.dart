import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/core/dialog/app_dialog.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/ReadyToDelivery.dart';
import 'package:single_vendor_admin/data/repository/Repositories/OrderRepository.dart';

class ReadyToDeliveryController extends GetxController {
  static ReadyToDeliveryController to = Get.find();

  OrderRepository _orderRepository = new OrderRepository();

  Rx<ReadyToDelivery> readyToDeliveryItems = new ReadyToDelivery().obs;

  RxBool loading = false.obs;

  getReadyToDeliveryItems() async {
    loading.value = true;

    Either<dynamic, Failure> _response =
        await _orderRepository.getReadyToDeliveryItems();

    _response.fold((l) {
      printInfo(info: "getAlreadyAcceptedOrder  Left : ${l}");
      ReadyToDelivery _readyToDeliveryItems = ReadyToDelivery.fromJson(l);
      printInfo(info: "Order Accepted :: ${_readyToDeliveryItems.success}");
      readyToDeliveryItems.value = _readyToDeliveryItems;

      loading.value = false;
    }, (r) {
      printInfo(info: "getAlreadyAcceptedOrder Right : ${r}");
      loading.value = false;
    });
  }

  deliverOrder(int? id, [BuildContext? context]) async {
    loading.value = true;
    Either<dynamic, Failure> _response =
        await _orderRepository.deliverOrder(id);

    _response.fold((l) {
      getReadyToDeliveryItems();
      print("deliverOrder Left   : ${l.toString()}");

      AppDialog.showDialog(
          context: context!,
          title: "Success",
          description: "Successfully  Delivered.");
    }, (r) {
      printInfo(info: "getAlreadyAcceptedOrder Right : ${r}");

      loading.value = false;
    });
  }
}
