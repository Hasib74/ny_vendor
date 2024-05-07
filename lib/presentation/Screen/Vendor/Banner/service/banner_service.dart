import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../../data/repository/remote/DataSource/URL.dart';
import '../model/banner_model.dart';
import 'package:http/http.dart' as http;

class BannerService {
  Future<BannerModel?> getBanner() async {
    try {
      var _res = await http.get(Uri.parse(URL.banner));

      if (_res.statusCode == 200) {
        BannerModel _bannerModel = BannerModel.fromJson(jsonDecode(_res.body));

        return _bannerModel;
      } else {
        return null;
      }
    } catch (err) {
      print("Error: $err");

      return null;
    }
  }

  Future<bool?> createOrUpdateBanner(File? file, String? name,
      {String? url}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url ?? URL.bannerStore), // Replace with your server URL
    );

    if (file!.path.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          file.path,
        ),
      );
    }

    request.fields['name'] = name!;
    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool>? deleteBanner(num num) async {
    var _res = await http.delete(Uri.parse("${URL.bannerDelete}${num}"));

    if (_res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
