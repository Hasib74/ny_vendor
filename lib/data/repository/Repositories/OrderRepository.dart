import 'package:dartz/dartz.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/repository/remote/Respositoris/OrderRemoteRepo.dart';

class OrderRepository {
  OrderRemoteRepo _orderRemoteRepo = new OrderRemoteRepo();

  Future<Either<dynamic, Failure>> getNewOrders() async {
    Either<dynamic, Failure> response = await _orderRemoteRepo.newOrder();

    //  Either<dynamic, Failure> userResponse = either;
    response.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });
    return response;
  }

  Future<Either<dynamic, Failure>> getAlreadyAcceptedOrder() async {
    Either<dynamic, Failure> response =
        await _orderRemoteRepo.getAlreadyAcceptedOrder();

    //  Either<dynamic, Failure> userResponse = either;
    response.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });
    return response;
  }

  Future<Either<dynamic, Failure>> orderProcessingDone(id) async {
    Either<dynamic, Failure> response =
        await _orderRemoteRepo.orderProcessingDone(id);

    //  Either<dynamic, Failure> userResponse = either;
    response.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });
    return response;
  }


  Future<Either<dynamic, Failure>> orderDetailsProductList(int? orderId) async {
    Either<dynamic, Failure> response =
    await _orderRemoteRepo.getOrderDetailsProductList(orderId);

    //  Either<dynamic, Failure> userResponse = either;
    response.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });
    return response;
  }

  Future<Either<dynamic, Failure>> getReadyToDeliveryItems() async {
    Either<dynamic, Failure> response =
        await _orderRemoteRepo.getReadyToDeliveryItems();

    //  Either<dynamic, Failure> userResponse = either;
    response.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });
    return response;
  }

  Future<Either<dynamic, Failure>> getOrderDetails(int? orderId) async {
    Either<dynamic, Failure> response =
        await _orderRemoteRepo.getOrderDetails(orderId);

    response.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });
    return response;
  }


  Future<Either<dynamic, Failure>> deliverOrder(int? id) async {
    Either<dynamic, Failure> response =
    await _orderRemoteRepo.deliverOrder(id);

    response.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });
    return response;
  }

  Future<Either<dynamic, Failure>> orderItemsDeliveryToDeliveryMan(
      int? orderId) async {
    Either<dynamic, Failure> response =
        await _orderRemoteRepo.orderItemsDeliveryToDeliveryMan(orderId);
    response.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });
    return response;
  }

  Future<Either<dynamic, Failure>?> pendingOrder() async {
    Either<dynamic, Failure>? response;
    var either = await _orderRemoteRepo.pendingOrder();

    Either<dynamic, Failure> userResponse = either;
    userResponse.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });
    return response;
  }

  Future<Either<dynamic, Failure>> getCompletedOrders() async {
    Either<dynamic, Failure> response =
        await _orderRemoteRepo.getCompletedOrders();
    response.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });
    return response;
  }
}
