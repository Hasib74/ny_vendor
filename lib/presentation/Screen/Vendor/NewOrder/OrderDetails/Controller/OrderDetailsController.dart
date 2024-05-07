

import 'package:dartz/dartz.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/CustomerModel.dart';
import 'package:single_vendor_admin/data/model/DeliverymanModel.dart';
import 'package:single_vendor_admin/data/model/new_order_model.dart';
import 'package:single_vendor_admin/data/repository/Repositories/OrderRepository.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstant.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';
import 'package:get/get.dart';
class OrderDetailsController extends GetxController{

  static OrderDetailsController to = Get.find();
  OrderRepository _orderRepository = new OrderRepository();
  Orders anOrderDetails = new Orders();
  RxBool dataLoading = true.obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }

  getOrderDetails(int? orderId) async{
    dataLoading.value = true;
    Either<dynamic, Failure> response = await _orderRepository.getOrderDetails(orderId);

    response.fold((l) {

      print("Left ===>  ${l['status_code']}");

      if (l[AppConstant.success].toString() == 'true' && l['status_code'].toString() == '200' ) {
        anOrderDetails = (l['message'] as List).map((item) => Orders.fromJson(item)).toList()[0];
      /*
       Map<String,dynamic>  details = l['message'][0];
        print('=========================  detail orders ${details['customer']}');
        anOrderDetails.orderDetails  = (details['order_details'] as List<dynamic>).map((anOrderDetails) => OrderDetailsModel.fromjson(anOrderDetails)).toList();
        anOrderDetails.customer = CustomerModel.fromjson(details['customer']);
        anOrderDetails.deliveryman =   DeliverymanModel.fromjson(details['delivery_man']);
        */
        dataLoading.value = false;
      }else {
        dataLoading.value = true;
        AppSnackBar.errorSnackbar(msg: l['message']);
      }
    }, (r) {
      print("Right ${r}");
    });

  }

}