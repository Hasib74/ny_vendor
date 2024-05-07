import 'package:flutter/foundation.dart';

class ProductOfferModel {
  var offerId, provderId, offerAmount;
  String? offerName, offerCode, offerDescription, offerUnit;

  ProductOfferModel(
      {this.offerId,
      this.offerName,
      this.offerCode,
      this.offerDescription,
      this.offerUnit,
      this.offerAmount,
      this.provderId});

  factory ProductOfferModel.fromJson(Map<String, dynamic> json) {
    print('offer details ' + json['name']);
    return ProductOfferModel(
      offerId: json['id'] as int?,
      offerName: json['name'],
      offerCode: json['code'],
      offerDescription: json['description'],
      offerUnit: json['offer_unit'],
      offerAmount: json['amount'] ,
      provderId: json['service_provider_id'],
    );
  }
}
