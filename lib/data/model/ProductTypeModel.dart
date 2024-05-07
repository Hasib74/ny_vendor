class ProductTypeModel {
  var id, providerId, serviceTypeId, productTypeName, productTypeImage;

  ProductTypeModel(
      {this.id,
      this.productTypeName,
      this.providerId,
      this.serviceTypeId,
      this.productTypeImage});

/*
  factory ProductTypeModel.fromJson(Map<String,dynamic>json){
     return ProductTypeModel(
       id: json['id'] as int,
       productTypeName: json['name'] as String,
       providerId: json['provider_id'] as int,
       serviceTypeId: json['service_type_id'] as int,
     );
  }

}

*/

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) {
    return ProductTypeModel(
        /*    id: json['product_type_id'],*/
        id: json['product_type_id'],
        productTypeName: json['product_type_name'],
        providerId: json['provider_id'],
        serviceTypeId: json['service_type_id'],
        productTypeImage: json['image']);
  }
}
