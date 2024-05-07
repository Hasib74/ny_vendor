/*
class NewOrders {
  String success;
  String statusCode;
  List<Orders> message;

  NewOrders({this.success, this.statusCode, this.message});

  NewOrders.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    if (json['message'] != null) {
      message = new List<Orders>();
      json['message'].forEach((v) {
        message.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    if (this.message != null) {
      data['message'] = this.message.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

*/

import 'package:single_vendor_admin/data/model/CustomerModel.dart';
import 'package:single_vendor_admin/data/model/DeliverymanModel.dart';
import 'package:single_vendor_admin/data/model/ProductOfferModel.dart';

class Orders {
  var id;
 // var deliveryName;
 // var deliveryAddress;
 // var deliveryPhone;
 // var customerName;
 // var customerAddress;
 // var customerPhone;
  var statusId;
  var orderCode;
  var orderStatus, paymentType, orderDateTime, orderDeliveryTime;

 // int customerId;
 // int deliverymanId;

  var totalAmount, deliveryFee, paidAmount,discount;
  ProductOfferModel? offerModel;
  List<OrderDetailsModel>? orderDetails;
  late CustomerModel customer;
  late DeliverymanModel deliveryman;

  Orders(
      {this.id,
     // this.deliveryName,
    //  this.deliveryAddress,
    //  this.deliveryPhone,
    //  this.customerName,
    //  this.customerAddress,
    //  this.customerPhone,
      this.statusId,
      this.orderCode,
      this.orderStatus,
      this.paymentType,
      this.orderDateTime,
      this.orderDeliveryTime,
      this.totalAmount,
      this.deliveryFee,
      this.paidAmount,this.discount});

  Orders.fromJson(Map<String, dynamic> json) {
    print('order details ---- ${json}');
    id = json['id'];
    statusId = json['status_id'];
    orderCode = json['order_code'].toString();
    orderStatus = 'Processing'; // json['order_status'];
    paymentType = json['payment_type'];// == 1 ? 'Cash':'Card';
    orderDateTime = json['order_datetime'];
    orderDeliveryTime = json['delivery_datetime'];
    totalAmount = json['total_amount'];
    deliveryFee = json['delivery_fee'] == null ? '0' : json['delivery_fee'];
    paidAmount = json['paid_amount'];
    discount = json['discount'];
    //  this.offerModel = ProductOfferModel.fromJson(json['offer']);
    this.orderDetails  = (json['order_details'] as List<dynamic>).map((anOrderDetails) => OrderDetailsModel.fromjson(anOrderDetails)).toList();
    this.customer = CustomerModel.fromjson(json['customer']);
    this.deliveryman =   DeliverymanModel.fromjson(json['delivery_man']);


  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status_id'] = this.statusId;
    return data;
  }
}

class OrderDetailsModel{
  var orderId,productNameId,amount,quantity;
  OrderDetailsModel({this.orderId,this.productNameId,this.amount,this.quantity});

  OrderDetailsModel.fromjson( Map<String, dynamic> json){
     this.orderId = json['order_id'];
     this.orderId = json['product_name_id'];
     this.orderId = json['amount'];
     this.orderId = json['quantity'];
   }
}
