class OrderPickedModel {
  String? success;
  String? statusCode;
  List<Message>? message;

  OrderPickedModel({this.success, this.statusCode, this.message});

  OrderPickedModel.fromJson(Map json) {
    print("Json decoding ::: ${json}");
    success = json['success'];
    statusCode = json['status_code'];
    if (json['message'] != null) {
      if (json["message"].toString() == "Data Not Found") {
        message = [];
      } else {
        message = <Message>[];

        print("New order message ::: ${json['message']}");
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
  int? customerId;
  var deliveryManId;
  String? orderCode;
  var offerId;
  int? orderStatusId;
  var totalAmount;
  var discount;
  var deliveryFee;
  var paidAmount;
  var paymentType;
  String? paymentStatus;
  String? customerPaymentId;
  var orderAddress;
  String? orderDatetime;
  var deliveryDatetime;
  String? orderAcceptTime;
  String? deliveryTime;
  String? itemsPickTime;
  int? distance;
  int? deliverySpeed;
  String? createdAt;
  String? updatedAt;
  List<OrderDetails>? orderDetails;
  var deliveryMan;
  Customer? customer;

  String? latValue;
  String? longValue;

  Message(
      {this.id,
      this.serviceProviderId,
      this.customerId,
      this.deliveryManId,
      this.orderCode,
      this.offerId,
      this.orderStatusId,
      this.totalAmount,
      this.discount,
      this.deliveryFee,
      this.paidAmount,
      this.paymentType,
      this.paymentStatus,
      this.customerPaymentId,
      this.orderAddress,
      this.orderDatetime,
      this.deliveryDatetime,
      this.orderAcceptTime,
      this.deliveryTime,
      this.itemsPickTime,
      this.distance,
      this.deliverySpeed,
      this.createdAt,
      this.updatedAt,
      this.orderDetails,
      this.deliveryMan,
      this.latValue,
      this.longValue,
      this.customer});

  Message.fromJson(json) {
    id = json['id'];
    serviceProviderId = json['service_provider_id'];
    customerId = json['customer_id'];
    deliveryManId = json['delivery_man_id'];
    orderCode = json['order_code'];
    offerId = json['offer_id'];
    orderStatusId = json['order_status_id'];
    totalAmount = json['total_amount'];
    discount = json['discount'];
    deliveryFee = json['delivery_fee'];
    paidAmount = json['paid_amount'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    customerPaymentId = json['customer_payment_id'];
    orderAddress = json['order_address'];
    orderDatetime = json['order_datetime'];
    deliveryDatetime = json['delivery_datetime'];
    orderAcceptTime = json['order_accept_time'];
    deliveryTime = json['delivery_time'];
    itemsPickTime = json['items_pick_time'];
    distance = json['distance'];
    deliverySpeed = json['delivery_speed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    latValue = json['lat_value'];
    longValue = json['long_value'];

    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
    deliveryMan = json['delivery_man'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_provider_id'] = this.serviceProviderId;
    data['customer_id'] = this.customerId;
    data['delivery_man_id'] = this.deliveryManId;
    data['order_code'] = this.orderCode;
    data['offer_id'] = this.offerId;
    data['order_status_id'] = this.orderStatusId;
    data['total_amount'] = this.totalAmount;
    data['discount'] = this.discount;
    data['delivery_fee'] = this.deliveryFee;
    data['paid_amount'] = this.paidAmount;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    data['customer_payment_id'] = this.customerPaymentId;
    data['order_address'] = this.orderAddress;
    data['order_datetime'] = this.orderDatetime;
    data['delivery_datetime'] = this.deliveryDatetime;
    data['order_accept_time'] = this.orderAcceptTime;
    data['delivery_time'] = this.deliveryTime;
    data['items_pick_time'] = this.itemsPickTime;
    data['distance'] = this.distance;
    data['delivery_speed'] = this.deliverySpeed;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.orderDetails != null) {
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
    }
    data['delivery_man'] = this.deliveryMan;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  int? id;
  int? orderId;
  int? productNameId;
  var amount;
  int? quantity;

  OrderDetails(
      {this.id, this.orderId, this.productNameId, this.amount, this.quantity});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productNameId = json['product_name_id'];
    amount = json['amount'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_name_id'] = this.productNameId;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Customer {
  int? id;
  String? fullName;
  String? address;
  String? email;
  String? phone;
  var photo;
  var genderId;
  int? countryId;
  var description;
  String? cardNumber;
  String? cardCvc;
  String? latValue;
  String? longValue;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.fullName,
      this.address,
      this.email,
      this.phone,
      this.photo,
      this.genderId,
      this.countryId,
      this.description,
      this.cardNumber,
      this.cardCvc,
      this.latValue,
      this.longValue,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    genderId = json['gender_id'];
    countryId = json['country_id'];
    description = json['description'];
    cardNumber = json['card_number'];
    cardCvc = json['card_cvc'];
    latValue = json['lat_value'];
    longValue = json['long_value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['address'] = this.address;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    data['gender_id'] = this.genderId;
    data['country_id'] = this.countryId;
    data['description'] = this.description;
    data['card_number'] = this.cardNumber;
    data['card_cvc'] = this.cardCvc;
    data['lat_value'] = this.latValue;
    data['long_value'] = this.longValue;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
