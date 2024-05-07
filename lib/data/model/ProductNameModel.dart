class ProductNameModel {
  bool? success;
  List<Products>? products;
  String? status;

  ProductNameModel({this.success, this.products, this.status});

  ProductNameModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['message'] != null) {
      products = <Products>[];
      try {
        json['message'].forEach((v) {
          products!.add(new Products.fromJson(v));
        });
      } catch (err) {
        print("ProductNameModel.fromJson :: ${err.toString()}");
      }
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.products != null) {
      data['message'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Products {
  int? id;
  String? productTypeName;
  int? isActive;
  int? providerId;
  int? serviceTypeId;
  List<ProductNames>? productNames;

  Products(
      {this.id,
      this.productTypeName,
      this.isActive,
      this.providerId,
      this.serviceTypeId,
      this.productNames});

  Products.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      productTypeName = json['product_type_name'];
      isActive = json['is_active'];
      providerId = json['provider_id'];
      serviceTypeId = json['service_type_id'];

      if (json['product_names'] != null) {
        productNames = <ProductNames>[];
        json['product_names'].forEach((v) {
          print("json['product_names']  :: ${v}");
          productNames!.add(new ProductNames.fromJson(v));
        });
      }
    } on Exception catch (e) {
      // TODO

      print("Products.fromJson  ${e.toString()}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_type_name'] = this.productTypeName;
    data['is_active'] = this.isActive;
    data['provider_id'] = this.providerId;
    data['service_type_id'] = this.serviceTypeId;
    if (this.productNames != null) {
      data['product_names'] = this.productNames!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductNames {
  int? id;
  String? productName;
  String? code;
  String? description;
  var price;
  String? imagePath;
  int? productTypeId;
  int? isActive;
  var quantity;

  var offer_amount;

  ProductNames(
      {this.id,
      this.productName,
      this.code,
      this.description,
      this.price,
      this.imagePath,
      this.productTypeId,
      this.quantity,
      this.offer_amount,
      this.isActive});

  ProductNames.fromJson(Map<String, dynamic> json) {
    print("Product Names Json ::: ${json.toString()}");

    //  id = json['id'];
    id = json['product_name_id'];
    productName = json['product_name'];
    code = json['code'];
    description = json['description'];
    price = json['price'];
    imagePath = json['imagePath'];
    productTypeId = json['product_type_id'];
    isActive = json['is_active'];
    /*   = json["product_stocks"];*/

    quantity = json["quantity"];

    offer_amount = json["offer_amount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['code'] = this.code;
    data['description'] = this.description;
    data['price'] = this.price;
    data['imagePath'] = this.imagePath;
    data['product_type_id'] = this.productTypeId;
    data['is_active'] = this.isActive;
    return data;
  }
}

/*class Stock {

  ProductStocks productStocks;

  Stock({this.productStocks});

  Stock.fromJson(Map<String, dynamic> json) {
    productStocks = json['product_stocks'] != null
        ? new ProductStocks.fromJson(json['product_stocks'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productStocks != null) {
      data['product_stocks'] = this.productStocks.toJson();
    }
    return data;
  }
}*/

class ProductStocks {
  var id;
  var quantity;
  var productNameId;

  ProductStocks({this.id, this.quantity, this.productNameId});

  ProductStocks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    productNameId = json['product_name_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['product_name_id'] = this.productNameId;
    return data;
  }
}
