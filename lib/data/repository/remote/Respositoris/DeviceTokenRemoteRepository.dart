import 'dart:convert';

import 'package:single_vendor_admin/data/repository/Repositories/DeviceTokenRepository.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/TokenController.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/Controller/AuthenticationController.dart';
import 'package:http/http.dart' as http;


class DeviceTokenRemoteRepository extends DeviceTokenRepository {

  String _TAG = "_DeviceTokenRemoteRepository"  ;

  @override
  saveDeviceToken(String deviceToken, String id) async {
    // TODO: implement saveDeviceToken
    //  throw UnimplementedError()
    try {
      Map<String, dynamic> _body = {"id": id, "device_token": deviceToken};
      var _header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${TokenController.to.token}'
      };
      var _response = await http.post(Uri.parse(URL.updateDeviceToken),
          body: jsonEncode(_body), headers: _header);

      print("${_TAG} url : ${URL.updateDeviceToken}") ;
      print("${_TAG} body : ${_body}") ;
      print("${_TAG} Device info Response : ${_response.body}") ;
      print("${_TAG} header : ${_header}") ;
    } on Exception catch (e) {
      // TODO
      print("${_TAG} error : ${e.toString()}") ;

    }

  }
}
