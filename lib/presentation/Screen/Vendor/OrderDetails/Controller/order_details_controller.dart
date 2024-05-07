import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/repository/Repositories/OrderRepository.dart';

import '../../../../../data/model/order_details.dart';

class OrderDetailsProductListController extends GetxController {
  static OrderDetailsProductListController to = Get.find();

  OrderRepository _orderRepository = new OrderRepository();

  Rx<OrderedProductListDetailsModel> orderedProductListDetails =
      new OrderedProductListDetailsModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getOrderDetails({int? orderId}) async {
    Either<dynamic, Failure> _response =
        await _orderRepository.orderDetailsProductList(orderId);

    _response.fold((l) {
      print("Order details procut list left : ${l}");

      orderedProductListDetails.value =
          OrderedProductListDetailsModel.fromJson(l);
    }, (r) {
      print("Order details procut list right : ${r}");
    });
  }

  priceCalculation() {
    double price = 0.0;

    if (orderedProductListDetails.value != null) {
      orderedProductListDetails.value.message!.orderDetails!.forEach((element) {
        price += (double.parse(element.amount.toString()) * element.quantity!);
      });
    }

    return price ;
  }
}
