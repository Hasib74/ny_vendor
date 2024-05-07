import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:single_vendor_admin/data/repository/Local/DataSource/MySharedPreference.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/TokenController.dart';

import '../../../../main.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

MySharedPreferenceController _mySharedPreferenceController = Get.find();

class ApiClient {
  static Future Request(
      {required String url,
      Method method = Method.GET,
      var body,
      bool enableHeader = false}) async {
    http.Response response;

    print('api token -------------- ${TokenController.to.token.toString()}');

    var _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${TokenController.to.token.toString()}'
    };
    try {
      if (method == Method.POST) {
        if (enableHeader) {
          response =
              await http.post(Uri.parse(url), body: body, headers: _header);
        } else {
          response = await http.post(Uri.parse(url), body: body);
        }
      } else if (method == Method.DELETE) {
        response = await http.delete(Uri.parse(url));
      } else if (method == Method.PATCH) {
        response = await http.patch(Uri.parse(url), body: body);
      } else {
        if (enableHeader) {
          response = await http.get(Uri.parse(url), headers: _header);
        } else {
          response = await http.get(Uri.parse(url));
        }
      }
      showData(
          url: url,
          body: body,
          method: method,
          response: response.body,
          header: _header);

      return jsonDecode(response.body);
    } catch (e) {
      print("Request Error :: $e");
      return {'error': language.someting_wrong};
    }
  }

  static Future RequestWithFile(
      {required String url,
      bool magic_method_allow = false,
      Map<String, String>? body,
      List<String>? fileKey,
      required List<File> files,
      Method method = Method.POST,
      Map? headerData,
      bool headerRequired = false}) async {
    var result;
    var uri = Uri.parse(url);
    late var request;
    if (method == Method.POST) {
      request = new http.MultipartRequest("POST", uri)..fields.addAll(body!);
    } else if (method == Method.PATCH) {
      request = new http.MultipartRequest("PATCH", uri)..fields.addAll(body!);
    } else if (method == Method.PUT) {
      request = new http.MultipartRequest("PUT", uri)..fields.addAll(body!);
    }

    var _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${TokenController.to.token.toString()}'
    };

    if (files.isNotEmpty) {
      for (int i = 0; i < fileKey!.length; i++) {
        print("Header FIle  Key ${fileKey[i]}");
        print("Header FIle   ${files[i]}");
        print("Header Path   ${files[i].path}");

        var stream =
            new http.ByteStream(DelegatingStream.typed(files[i].openRead()));
        var length = await files[i].length();
        var multipartFile = new http.MultipartFile(fileKey[i], stream, length,
            filename: basename(files[i].path));

        print("multipartFile filed ::: ${multipartFile.field}");
        print("multipartFile contentType ::: ${multipartFile.contentType}");
        print("multipartFile filename ::: ${multipartFile.filename}");
        //  print("multipartFile filed ::: ${multipartFile}") ;
        request.files.add(multipartFile);
      }
    }

    if (headerRequired) {
      print("Header Added  ${_header}");
      request.headers.addAll(_header);
    }
    var response;
    try {
      print("Request for : ${request}");
      response = await request.send();
    } catch (err) {
      print("Request send error :: ${err.toString()}");
    }

    print("The Response : ${response}");
    await response.stream.transform(utf8.decoder).listen((value) {
      result = value;
      print(result);
    });
    showData(url: url, body: body, method: method, response: result.toString());
    return jsonDecode(result);
  }

  static void showData(
      {String? url, var body, String? response, Method? method, var header}) {
    if (!kReleaseMode) {
      //print("Header = $header");
      print("URL = $url");
      print("Body = $body");
      print("Method = $method");
      print("Header = ${header}");
      print("Header token = ${TokenController.to.token}");
      print("Response = $response");
    }
  }

// static Map<String, String> header = {
//   'Content-Type': 'application/json',
//   'Accept': 'application/json',
//   'Authorization': 'Bearer ${TokenController.to.token}'
// };
}
