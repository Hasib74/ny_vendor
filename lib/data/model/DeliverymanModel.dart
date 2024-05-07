

import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';

class DeliverymanModel{
  var deliverymanId,name,address,email,phone,deliverymanPhoto;
  DeliverymanModel({this.deliverymanId,this.name,this.address,this.email,this.phone,this.deliverymanPhoto});

  DeliverymanModel.fromjson( Map<String, dynamic> json){
    this.deliverymanId = json['delivery_man_ID'];
    this.name = json['full_name'];
    this.address = json['address'];
    this.email = json['email'];
    this.phone = json['phone'];
    this.deliverymanPhoto = json['delivery_men_image'] != null ? URL.host_url + json['delivery_men_image'] : null ;


  }
}
