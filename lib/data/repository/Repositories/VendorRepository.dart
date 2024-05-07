import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/data/model/VendorModel.dart';
import 'package:single_vendor_admin/data/repository/remote/Respositoris/VendorRemoteRepository.dart';
import 'package:single_vendor_admin/presentation/Controller/AppMood/AppMood.dart';
import 'package:single_vendor_admin/presentation/Controller/AppMood/AppMoodController.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class VendorRepository {
  VendorRemoteRepository _vendorRemoteRepository = new VendorRemoteRepository();

  AppMoodController _appMoodController = Get.find();

  Future<Either<Response, Failure>?> vendorSignUp(
      VendorModel vendorModel, File profileImage) async {
    printInfo(info: "AppMood ::: ${_appMoodController.appMood}");

    Either<Response, Failure>? response;

    var either =
        await _vendorRemoteRepository.signUp(vendorModel, profileImage);
    switch (_appMoodController.appMood) {
      case AppMood.DEMO:
        Either<Response, Failure> vendorResponse = either;
        vendorResponse.fold((l) {
          response = Left(l);
        }, (r) {
          response = Right(r);
        });
        break;
      case AppMood.DEV:
        // TODO: Handle this case.
        break;
      case AppMood.STABLE:
        // TODO: Handle this case.
        break;
    }

    return response;
  }

  Future<Either<Response, Failure>> vendorProfile() async {
    printInfo(info: "AppMood ::: ${_appMoodController.appMood}");

    Either<Response, Failure>? response;

    switch (_appMoodController.appMood) {
      case AppMood.DEMO:
        Either<Response, Failure> vendorResponse =
            await _vendorRemoteRepository.vendorProfile();

        vendorResponse.fold((l) {
          response = Left(l);
        }, (r) {
          response = Right(r);
        });
        break;
      case AppMood.DEV:
        // TODO: Handle this case.
        break;
      case AppMood.STABLE:
        // TODO: Handle this case.
        break;
    }

    return response!;
  }

  Future<Either<Response, Failure>?> updateVendorProfile(
      {VendorModel? vendorModel, File? file, String? imageKey}) async {
    printInfo(info: "AppMood ::: ${_appMoodController.appMood}");

    Either<Response, Failure>? response;

    switch (_appMoodController.appMood) {
      case AppMood.DEMO:
        Either<Response, Failure> vendorResponse =
            await _vendorRemoteRepository.updateVendorProfile(
                vendorModel: vendorModel, file: file, imageKey: "vendor_image");
        vendorResponse.fold((l) {
          response = Left(l);
        }, (r) {
          response = Right(r);
        });
        break;
      case AppMood.DEV:
        // TODO: Handle this case.
        break;
      case AppMood.STABLE:
        // TODO: Handle this case.
        break;
    }

    return response;
  }

  Future<Either<dynamic, Failure>?> addLocation(LatLng latlng) async {
    printInfo(info: "AppMood ::: ${_appMoodController.appMood}");

    Either<dynamic, Failure>? response;

    Either<dynamic, Failure> vendorResponse =
        await _vendorRemoteRepository.updateVendorLocation(latLng: latlng);
    vendorResponse.fold((l) {
      response = Left(l);
      printInfo(info: "Location Update Response :: ${response}");

    }, (r) {
      response = Right(r);
    });


    return response;
  }

  Future<Either<dynamic, Failure>?> sendAccountRecoveryPassword(
      String? phoneNo) async {
    Either<dynamic, Failure>? response;
    Either<dynamic, Failure> responseResult =
        await _vendorRemoteRepository.sendAccountRecoveryPassword(phoneNo);

    responseResult.fold((l) {
      return response = Left(l);
    }, (r) {
      return response = Right(r);
    });
    return response;
  }

  Future<Either<dynamic, Failure>> updatePassword(body) async {
    Either<dynamic, Failure> data =
        await _vendorRemoteRepository.updateNewPassword(body);

    return data.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<dynamic, Failure>> creteBankInfo(body) async {
    Either<dynamic, Failure> data =
        await _vendorRemoteRepository.creteBankInfo(body);

    return data.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<dynamic, Failure>> updateBankInfo(body) async {
    Either<dynamic, Failure> data =
        await _vendorRemoteRepository.updateBankInfo(body);

    return data.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Response, Failure>> getBankInfo() async {
    Either<Response, Failure> data =
        await _vendorRemoteRepository.getBankInfo();

    return data.fold((l) => Left(l), (r) => Right(r));
  }
}
