import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/repository/Repositories/OrderItemsPickedRepo.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/TokenController.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';

class OrderItemsRemoteRepository extends OrderItemsPickedRepository {
  var _header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${TokenController.to.token.toString()}'
  };

  @override
  Future<Either<Failure, http.Response>> getOrderPickedList() async {
    // TODO: implement getOrderPickedList
    printInfo(info: "getOrderPickedList URL : ${URL.getOrderPickedItem}");
    printInfo(info: "getOrderPickedList header : ${_header}");

    Either<Failure, http.Response> _either_response;

    try {
      var _response =
          await http.get(Uri.parse(URL.getOrderPickedItem), headers: _header);

      printInfo(info: "getOrderPickedList list : ${_response.body}");

      return Right(_response);
    } catch (err) {
      printInfo(info: "getOrderPickedList  : err  ${err.toString()}");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, http.Response>> acceptOrderRequest(id) async {
    // TODO: implement getOrderPickedList

    Either<Failure, http.Response> _either_response;
    var _body = {'order_id': id};
    try {
      var _response = await http.post(Uri.parse(URL.orderPickedOrderAccept),
          headers: _header, body: jsonEncode(_body));
      _either_response = Right(_response);
    } catch (err) {
      printInfo(info: "getOrderPickedList  : err  ${err.toString()}");
      _either_response = Left(ServerFailure());
    }

    return _either_response;
  }
}
