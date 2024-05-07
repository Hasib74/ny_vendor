import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/core/network/network_info.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/ApiClient.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';

class OrderRemoteRepo {
  NetworkInfoController _networkInfoController = Get.find();

  Future<Either<dynamic, Failure>> newOrder() async {
    try {
      if (await _networkInfoController.isConnected()) {
        print("Url : =>  ${URL.getAllNewOrder}");
        dynamic response = await ApiClient.Request(
            url: "${URL.getAllNewOrder}", enableHeader: true);
        print("Response from remote ${response}");
        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());

      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> getAlreadyAcceptedOrder() async {
    try {
      if (await _networkInfoController.isConnected()) {
        print("Url : =>  ${URL.vendor_order_already_accepted}");
        dynamic response = await ApiClient.Request(
            url: "${URL.vendor_order_already_accepted}", enableHeader: true);
        print("Response from remote ${response}");
        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());

      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> getOrderDetails(int? orderId) async {
    try {
      Map<String, dynamic> bodyData = {
        "id": orderId,
      };
      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.getOrderDetails,
            body: jsonEncode(bodyData),
            enableHeader: true,
            method: Method.POST);
        printInfo(info: "New Order details Response ::: ${response}");
        return Left(response);
      } else {
        print("Noooooooooo Network");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err} ");
      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> getOrderDetailsProductList(int? orderId) async {
    try {
     /* Map<String, dynamic> bodyData = {
        "id": orderId,
      };*/
      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.getOrderProductList+"${orderId}",
            enableHeader: true,
            method: Method.GET);
        printInfo(info: "New Order details productlist Response ::: ${response}");
        return Left(response);
      } else {
        print("Noooooooooo Network");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err} ");
      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> orderItemsDeliveryToDeliveryMan(
      int? orderId) async {
    try {
      Map<String, dynamic> bodyData = {
        "id": orderId,
      };
      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.orderItemDeliveryToDeliveryman,
            body: jsonEncode(bodyData),
            enableHeader: true,
            method: Method.POST);
        printInfo(
            info: "New Order delivery to deliveryman Response ::: ${response}");
        return Left(response);
      } else {
        print("Noooooooooo Network");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err} ");
      return Right(ServerFailure());
    }
  }

  Future<dynamic> orderAccept(orderId) async {
    // bool result = false;
    // Map<String,dynamic> bodyData = {
    //   "id" : orderId.id,
    // };
    // try{
    //  if (await _networkInfoController.isConnected()) {
    //   http.Response response = await ApiClient.Request(
    //   url: ApiUrls.acceptOrder,
    //   body: jsonEncode(bodyData),
    //   enableHeader: true,
    //   method: Method.POST
    //   );
    //   if (jsonDecode(response.body)["error"]  != null) {
    //     print("Error on api");
    //     Get.snackbar(
    //       "Error !!!",
    //     response.body.toString(),
    //     );
    //   }else {
    //     print("api done");
    //     print("iddddddddd...check ${orderId.id}");
    //     return response;
    //   }
    //   } else {
    //     print("Noooooooooo Network");

    //   }
    // }catch (err) {
    //    print("Error : ${err}");
    // }
  }

  Future<dynamic> orderDecline(orderId) async {
    // bool result = false;
    // Map<String,dynamic> bodyData = {
    //   "id" : orderId.id,
    // };
    // try {
    //   if (await _networkInfoController.isConnected()) {
    //     http.Response response = await ApiClient.Request(
    //       url: ApiUrls.declineOrder,
    //       body: jsonEncode(bodyData),
    //       enableHeader: true,
    //       method: Method.POST
    //     );
    //     if (jsonDecode(response.body)["error"] != null) {
    //       print("Error on APi");
    //       Get.snackbar("Error !!!",
    //       response.body.toString(),
    //       );
    //     }else {
    //        print("api done");
    //       print("iddddddddd...check ${orderId.id}");
    //       return response;
    //     }
    //   } else {
    //     print("Nooooo  Network...........");
    //   }
    // }catch (err) {
    //    print("Error : ${err}");
    // }
  }

  Future<Either<dynamic, Failure>> pendingOrder() async {
    try {
      if (await _networkInfoController.isConnected()) {
        dynamic response = await ApiClient.Request(
            url: URL.getCompletedOrders,
            enableHeader: true,
            method: Method.GET);
        print("Pending Order response......... ${response}");
        return Left(response);
      } else {
        print("No Netork..............please connect with network");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> getCompletedOrders() async {
    try {
      if (await _networkInfoController.isConnected()) {
        print("Url : =>  ${URL.getCompletedOrders}");
        dynamic response = await ApiClient.Request(
            url: "${URL.getCompletedOrders}", enableHeader: true);
        print("Response from remote ${response}");
        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());

      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> getAllOrders() async {
    try {
      if (await _networkInfoController.isConnected()) {
        print("Url : =>  ${URL.getCompletedOrders}");
        dynamic response = await ApiClient.Request(
            url: "${URL.getTotalOrders}", enableHeader: true);
        print("Response from remote ${response}");
        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());
      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> getReadyToDeliveryItems() async {
    try {
      if (await _networkInfoController.isConnected()) {
        print("Url : =>  ${URL.orderReadyOrderList}");
        dynamic response = await ApiClient.Request(
            url: "${URL.orderReadyOrderList}", enableHeader: true);
        print("Response from remote ${response}");
        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());
      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> orderProcessingDone(int id) async {
    try {
      if (await _networkInfoController.isConnected()) {
        print("Url..................  ${URL.orderProcessingDone + "/${id}"}");

        dynamic response = await ApiClient.Request(
            url: "${URL.orderProcessingDone + "/${id}"}", enableHeader: true);
        // print("Response from remote ${response}");
        print("Response from remote ${response}");
        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());
      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> deliverOrder(int? id) async {
    try {
      if (await _networkInfoController.isConnected()) {
        print(
            "Url..................  ${URL.orderDeliveredByVendor + "/${id}"}");

        dynamic response = await ApiClient.Request(
            url: "${URL.orderDeliveredByVendor + "${id}"}", enableHeader: true);
        // print("Response from remote ${response}");
        print("Response from remote ${response}");
        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());
      return Right(ServerFailure());
    }
  }

  Future<dynamic> itemPickFromRestaurant(orderId) async {
    // bool result = false;
    // Map<String,dynamic> bodyData = {
    //   "id" : orderId.id,
    // };
    // try{
    //  if (await _networkInfoController.isConnected()) {
    //   http.Response response = await ApiClient.Request(
    //   url: ApiUrls.itemPickFromVendor,
    //   body: jsonEncode(bodyData),
    //   enableHeader: true,
    //   method: Method.POST
    //   );
    //   if (jsonDecode(response.body)["error"]  != null) {
    //     print("Error on api");
    //     Get.snackbar(
    //       "Error !!!",
    //     response.body.toString(),
    //     );
    //   }else {
    //     print("api done");
    //     print("iddddddddd...check ${orderId.id}");
    //     return response;
    //   }
    //   } else {
    //     print("Noooooooooo Network");

    //   }
    // }catch (err) {
    //    print("Error : ${err}");
    // }
  }

  Future<dynamic> deliveredOrderToCustomer(orderId) async {
    // bool result = false;
    // Map<String,dynamic> bodyData = {
    //   "id" : orderId.id,
    // };
    // try{
    //   if (await _networkInfoController.isConnected()) {
    //     http.Response response = await ApiClient.Request(
    //       url: ApiUrls.completedOrder,
    //       body: jsonEncode(bodyData),
    //       enableHeader: true,
    //       method: Method.POST
    //       );

    //       if (jsonDecode(response.body)["error"] != null) {
    //         print("error on api");
    //         Get.snackbar("Error !!!", response.body.toString());
    //       }else {
    //         print("api done.........");
    //         return response;
    //       }
    //   }else {
    //     print("N00000000 Network.......");
    //   }
    // }catch(err) {
    //   print("Error : ${err}");
    // }
  }
}
