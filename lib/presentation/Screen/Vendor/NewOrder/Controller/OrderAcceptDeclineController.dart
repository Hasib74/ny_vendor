/*
import 'dart:convert';
import 'package:single_vendor_admin/data/model/new_order_model.dart';
import 'package:single_vendor_admin/data/repository/Repositories/OrderRepository.dart';
import 'package:single_vendor_admin/data/repository/remote/Respositoris/OrderRemoteRepo.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/Core/Error/failures.dart';
import 'package:single_vendor_admin/Data/Model/new_order_model.dart' as order;


class OrderAcceptOrDelineController extends GetxController {
   static OrderAcceptOrDelineController to = Get.find();


 
  OrderRepository _orderRepository = new OrderRepository();
  
  OrderRemoteRepo _orderRemoteRepo = new OrderRemoteRepo();


  Rx<NewOrders> newOrder = new NewOrders().obs;

  order.Orders selectedOptionAccept;
  order.Orders selectedOptionDecline;

  RxBool loading = false.obs;

  @override
  void onInit() {
    update();

    print("===================${selectedOptionAccept}");
 
    getNewOrders();
     orderAccept();
    super.onInit();
  }

  updateUI() async {
    newOrder = await getNewOrders();
    update();
  }
  getNewOrders() async {
    Either<dynamic, Failure> response = await _orderRepository.getNewOrders();

    response.fold((l) {
      print("Left ===>  ${l.body}");

      newOrder.value = NewOrders.fromJson(jsonDecode(l.body));

      print("New Order value ===> ${newOrder.value.message[0].id}");
    }, (r) {
      print("Right ${r}");
    });
  }

  orderAccept() async {
    loading.value = true;
    if (selectedOptionAccept == null) {
      print("noooooooooo accept api is call");
      getNewOrders();
    }else {
      dynamic response = await _orderRemoteRepo.orderAccept(selectedOptionAccept);
      print("okeyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy........${response}");
      if( jsonDecode(response.body)["status_code"].toString().endsWith("200")) {
        selectedOptionAccept == null;
        AppLoading();
        updateUI();
        AppSnackBar.successSnackbar(msg: "Accept successfully");
        getNewOrders();
        // loading.value = false;
      
      }
    }
  }

  orderDecline() async {
    loading.value = true;
    if (selectedOptionDecline == null) {
      getNewOrders();
    }else{
      dynamic response = await _orderRemoteRepo.orderDecline(selectedOptionDecline);
      print("declineeeeeeeeeeee=============== ${response}");
      if(jsonDecode(response.body)["status_code"].toString().endsWith("200")) {
        selectedOptionDecline == null;
          AppLoading();
         updateUI();
        AppSnackBar.successSnackbar(msg: "Decline successfully");
      //  loading.value = false;
      }

    }
  }


}

*/
