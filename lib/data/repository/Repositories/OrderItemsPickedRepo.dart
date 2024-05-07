import 'package:dartz/dartz.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:http/http.dart' as http;

abstract class OrderItemsPickedRepository {
  Future<Either<Failure ,http.Response>> getOrderPickedList() ;
  Future<Either<Failure ,http.Response>> acceptOrderRequest(id) ;

}