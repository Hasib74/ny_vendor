import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/OrderAccepetedModel.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';
import 'package:single_vendor_admin/data/repository/remote/Respositoris/OrderRemoteRepo.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';

import '../../../../../../core/dialog/app_dialog.dart';
import '../../../../../../data/model/delivery_man.dart';

import 'package:http/http.dart' as http;

import '../../../../../../data/repository/remote/DataSource/TokenController.dart';

class CookingItemsController extends GetxController {
  static CookingItemsController to = Get.find();

  OrderRemoteRepo _orderRepository = OrderRemoteRepo();

  Rx<OrderAcceptedModel> orderAcceptedModel = new OrderAcceptedModel().obs;

  RxBool loading = false.obs;

  RxBool assignNowLoading = false.obs;

  int? loadingId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getAlreadyAcceptedOrder() async {
    loading(true);

    Either<dynamic, Failure> _response =
        await _orderRepository.getAlreadyAcceptedOrder();

    _response.fold((l) {
      loading(false);

      printInfo(info: "getAlreadyAcceptedOrder  Left : ${l}");
      OrderAcceptedModel _orderAcceptedModel = OrderAcceptedModel.fromJson(l);
      printInfo(info: "Order Accepted :: ${_orderAcceptedModel.success}");
      orderAcceptedModel.value = _orderAcceptedModel;
    }, (r) {
      loading(false);

      printInfo(info: "getAlreadyAcceptedOrder Right : ${r}");
    });
  }

  orderProcessingDone(int id, [BuildContext? context]) async {
    loading(true);

    Either<dynamic, Failure> _response =
        await _orderRepository.orderProcessingDone(id);

    _response.fold((l) {
      printInfo(info: "getAlreadyAcceptedOrder  Left : ${l}");

      loading(false);

      getAlreadyAcceptedOrder();

      AppDialog.showDialog(
          context: context!,
          title: "Success",
          description: "Successfully cooked.");
    }, (r) {
      loading(false);

      printInfo(info: "getAlreadyAcceptedOrder Right : ${r}");
    });
  }

  Future<DeliveryMan?> getDeliveryMan() async {
    DeliveryMan? deliveryMan;

    http.Response data = await http
        .get(Uri.parse("${URL.base_url}get-all-delivery_man"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${TokenController.to.token}',
    });

    if (data.statusCode == 200) {
      deliveryMan = DeliveryMan.fromJson(jsonDecode(data.body));
    } else {
      AppSnackBar.errorSnackbar(msg: "Failed to load delivery man.");
    }

    return deliveryMan;
  }

  Future<bool> assignNow({int? deliveryManId, int? orderId}) async {
    bool isSuccess = false;

    loadingId = deliveryManId;

    assignNowLoading(true);

    http.Response data = await http.post(
        Uri.parse("${URL.base_url}vendor/assign/delivery_man/${orderId}"),
        body: {
          "delivery_men_id": deliveryManId.toString()
        },
        headers: {
          // 'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${TokenController.to.token}',
        });

    print("${data.body}");

    if (data.statusCode == 200) {
      assignNowLoading(false);
      loadingId = null;
      isSuccess = true;
    } else {
      loadingId = null;
      assignNowLoading(false);
      AppSnackBar.errorSnackbar(msg: "Failed to assign delivery man.");
      isSuccess = false;
    }

    return isSuccess;
  }
}
