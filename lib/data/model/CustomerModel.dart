
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';

class CustomerModel{

  var customerId,name,address,email,phone,customerPhoto;
  CustomerModel({this.customerId,this.name,this.address,this.email,this.phone,this.customerPhoto});

  CustomerModel.fromjson( Map<String, dynamic> json){
    this.customerId = json['id'];
    this.name = json['full_name'];
    this.address = json['address'];
    this.email = json['email'];
    this.phone = json['phone'];
    this.customerPhoto =  json['photo'] != null ? URL.host_url + json['photo'] : null ;

  }
}
