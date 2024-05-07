// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VendorModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorModel _$VendorModelFromJson(Map<String, dynamic> json) {
  return VendorModel(
    id: json['id'] as int?,
    address: json['address'] as String?,
    description: json['description'] as String?,
    phoneNumber: json['phone'] as String?,
    closingTime: json['closing_time'] as String?,
    fullName: json['full_name'] as String?,
    openingTime: json['opening_time'] as String?,
    shopName: json['shop_name'] as String?,
    c_password: json['c_password'] as String?,
    email: json['email'] as String?,
    password: json['password'] as String?,
    userName: json['user_name'] as String?,
    vendorImage: json['vendorImage'] as String?,
    service_provider_id: json["service_provider_id"] as String?
  );
}

Map<String, String> _$VendorModelToJson(VendorModel instance) =>
    <String, String>{
      'address': instance.address ?? "",
      'closing_time': instance.closingTime ?? "",
      'description': instance.description ?? "",
      'full_name': instance.fullName ?? "",
      'opening_time': instance.openingTime ?? "",
      'phone': instance.phoneNumber ?? "",
      'shop_name': instance.shopName ?? "",
      // 'vendorImage': instance.vendorImage,
      'email': instance.email ?? "",
      'user_name': instance.email ?? "",
      'password': instance.password ?? "",
      'c_password': instance.c_password ?? "",
      'country_id': instance.country_id ?? "",
      'delivery_charge': instance.delivery_charge ?? "",
      'lat_value': instance.lat_value ?? "",
      'long_value': instance.long_value ?? ""
    };

/*
*   String country_id;

  String delivery_charge;

  String lat_value;

  String long_value;
*
*
* */
