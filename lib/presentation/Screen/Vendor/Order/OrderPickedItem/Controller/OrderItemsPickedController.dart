import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/OrderPicked.dart';
import 'package:single_vendor_admin/data/repository/Repositories/OrderItemsPickedRepo.dart';
import 'package:single_vendor_admin/data/repository/remote/Respositoris/OrderItemsPickedRemoteRepository.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';

import '../../../../../../core/dialog/app_dialog.dart';
import '../../../../../../data/model/order_picked_model.dart';

class OrderItemsPickedController extends GetxController {
  static OrderItemsPickedController to = OrderItemsPickedController();
  OrderItemsPickedRepository _orderItemsPickedRepository =
      new OrderItemsRemoteRepository();
  Rx<OrderPickedModel> orderPickedModel = new OrderPickedModel().obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getPickedItems() async {
    loading.value = true;
    Either<Failure, http.Response> _res =
        await _orderItemsPickedRepository.getOrderPickedList();
    _res.fold((l) {
      printInfo(info: "Order picked item  Left :: ${l}");

      loading.value = false;
      AppSnackBar.errorSnackbar(msg: "Failed to load order picked items.");
    }, (r) {
      printInfo(info: "Order picked item  Right :: ${r.body}");

      loading.value = false;

      try {
        orderPickedModel.value = OrderPickedModel.fromJson(jsonDecode(r.body));
      } on Exception catch (e) {
        // TODO

        printInfo(info: "Order picked item  Right error:: ${e.toString()}");
      }
    });
  }

  pickedOrderAccept(id, BuildContext context) async {
    loading.value = true;
    var _res = await _orderItemsPickedRepository.acceptOrderRequest(id);
    _res.fold((l) {
      loading.value = false;
      AppSnackBar.errorSnackbar(msg: "Failed to accept.");
    }, (r) {
      printInfo(info: r.body);
      loading.value = false;
      getPickedItems();

      AppDialog.showDialog(
          context: context,
          title: "Success",
          description: "Successfully accepted order");
    });
  }
}
