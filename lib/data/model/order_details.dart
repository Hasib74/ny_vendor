class OrderedProductListDetailsModel {
  String? success;
  String? statusCode;
  Message? message;
  List<ProductDetails>? productDetails;

  OrderedProductListDetailsModel(
      {this.success, this.statusCode, this.message, this.productDetails});

  OrderedProductListDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message =
    json['message'] != null ?  new Message.fromJson(json['message']) : null;
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails!.map((v) => v.toJson()).toList();
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
        this.orderDetails});

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
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
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

class ProductDetails {
  int? productNameId;
  String? productName;
  String? code;
  String? description;
  var price;
  int? quantity;
  String? imagePath;
  int? productTypeId;
  int? isActive;

  ProductDetails(
      {this.productNameId,
        this.productName,
        this.code,
        this.description,
        this.price,
        this.quantity,
        this.imagePath,
        this.productTypeId,
        this.isActive});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    productNameId = json['product_name_id'];
    productName = json['product_name'];
    code = json['code'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    imagePath = json['imagePath'];
    productTypeId = json['product_type_id'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name_id'] = this.productNameId;
    data['product_name'] = this.productName;
    data['code'] = this.code;
    data['description'] = this.description;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['imagePath'] = this.imagePath;
    data['product_type_id'] = this.productTypeId;
    data['is_active'] = this.isActive;
    return data;
  }
}
