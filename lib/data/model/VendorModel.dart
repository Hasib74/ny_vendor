import 'dart:core';
import 'package:single_vendor_admin/domain/entities/StatusEntities.dart';
import 'package:single_vendor_admin/domain/entities/UserEntities.dart';
import 'package:single_vendor_admin/presentation/Constant/AppConstantData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'VendorModel.g.dart';

@JsonSerializable()
class VendorModel implements VendorEntities {
  @override
  int? id;
  @override
  String? address;
  @override
  String? closingTime;
  @override
  String? description;
  @override
  String? fullName;
  @override
  String? openingTime;
  @override
  String? phoneNumber;
  @override
  String? shopName;
  @override
  String? vendorImage;
  @override
  String? email;
  @override
  String? userName;
  String? password;
  String? c_password;

  //Extra added for vendor update profile ,
  var country_id;
  String? delivery_charge;
  String? lat_value;
  String? long_value;
  @override
  String? rating;
  int? updateBy;
  int? isActive;
  var zip;
  var city_id;

  var state_id;

  var service_provider_id ;

  VendorModel(
      {this.id,
      this.address,
      this.description,
      this.phoneNumber,
      this.closingTime,
      this.fullName,
      this.openingTime,
      this.shopName,
      this.c_password,
      this.email,
      this.password,
      this.userName,
      this.vendorImage,
      this.country_id,
      this.delivery_charge,
      this.lat_value,
      this.long_value,
      this.rating,
      this.updateBy,
      this.isActive,
      this.state_id,
      this.city_id,
        this.service_provider_id,
      this.zip});

  factory VendorModel.fromJson(Map<String, dynamic> json) =>
      _$VendorModelFromJson(json);

  Map<String, dynamic> toJson() => _$VendorModelToJson(this);
}
