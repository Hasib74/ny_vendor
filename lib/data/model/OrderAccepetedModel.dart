class OrderAcceptedModel {
  String? success;
  String? statusCode;
  List<Message>? message;

  OrderAcceptedModel({this.success, this.statusCode, this.message});

  OrderAcceptedModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    if (json['message'] != null) {

      if(json['message']  == "Data Not Found"){
        message = <Message>[];
      }else{
        message = <Message>[];
        json['message'].forEach((v) {
          message!.add(new Message.fromJson(v));
        });
      }


    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  int? id;
  int? serviceProviderId;
  int? serviceTableId;
  int? customerId;
  var customerEmail;
  String? orderCode;
  int? offerId;
  int? orderStatus;
  var paymentReference;
  var totalAmount;
  var discount;
  var paidAmount;
  var paymentMethod;
  var paymentMeta;
  String? paymentStatus;
  String? customerPaymentId;
  String? createdAt;
  String? updatedAt;
  List<OrderDetails>? orderDetails;
  Customer? customer;

  Message(
      {this.id,
      this.serviceProviderId,
      this.serviceTableId,
      this.customerId,
      this.customerEmail,
      this.orderCode,
      this.offerId,
      this.orderStatus,
      this.paymentReference,
      this.totalAmount,
      this.discount,
      this.paidAmount,
      this.paymentMethod,
      this.paymentMeta,
      this.paymentStatus,
      this.customerPaymentId,
      this.createdAt,
      this.updatedAt,
      this.orderDetails,
      this.customer});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceProviderId = json['service_provider_id'];
    serviceTableId = json['service_table_id'];
    customerId = json['customer_id'];
    customerEmail = json['customer_email'];
    orderCode = json['order_code'];
    offerId = json['offer_id'];
    orderStatus = json['order_status'];
    paymentReference = json['payment_reference'];
    totalAmount = json['total_amount'];
    discount = json['discount'];
    paidAmount = json['paid_amount'];
    paymentMethod = json['payment_method'];
    paymentMeta = json['payment_meta'];
    paymentStatus = json['payment_status'];
    customerPaymentId = json['customer_payment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }

    if (json['customer'] != null) {
      customer = new Customer.fromJson(json['customer']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_provider_id'] = this.serviceProviderId;
    data['service_table_id'] = this.serviceTableId;
    data['customer_id'] = this.customerId;
    data['customer_email'] = this.customerEmail;
    data['order_code'] = this.orderCode;
    data['offer_id'] = this.offerId;
    data['order_status'] = this.orderStatus;
    data['payment_reference'] = this.paymentReference;
    data['total_amount'] = this.totalAmount;
    data['discount'] = this.discount;
    data['paid_amount'] = this.paidAmount;
    data['payment_method'] = this.paymentMethod;
    data['payment_meta'] = this.paymentMeta;
    data['payment_status'] = this.paymentStatus;
    data['customer_payment_id'] = this.customerPaymentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  int? orderDetailsId;
  int? orderId;
  int? productNameId;
  var amount;
  int? quantity;

  OrderDetails(
      {this.orderDetailsId,
      this.orderId,
      this.productNameId,
      this.amount,
      this.quantity});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    orderDetailsId = json['order_details_id'];
    orderId = json['order_id'];
    productNameId = json['product_name_id'];
    amount = json['amount'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_details_id'] = this.orderDetailsId;
    data['order_id'] = this.orderId;
    data['product_name_id'] = this.productNameId;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Customer {
  int? customerId;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.customerId,
      this.fullName,
      this.email,
      this.phone,
      this.address,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
