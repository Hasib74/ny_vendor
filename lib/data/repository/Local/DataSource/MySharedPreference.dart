import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_vendor_admin/data/repository/Local/DataSource/AppLocalKey.dart';

class MySharedPreferenceController extends GetxController {
  static MySharedPreferenceController to = Get.find();
  late SharedPreferences sp;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    shareSharedPreferenceInitialize();
  }

  shareSharedPreferenceInitialize() async {
    sp = await SharedPreferences.getInstance();
    update();
    print("SP initialize");
  }

  setLoginToken(String token) async {
    // SharedPreferences _sp = await SharedPreferences.getInstance();
    await sp.setString(AppLocalKey.token, token);
  }

  //
  String getLoginToken() {
    // SharedPreferences _sp = await SharedPreferences.getInstance();

    var _token = sp.getString(AppLocalKey.token);

    if (_token == null) {
      return "";
    } else {
      return _token;
    }
    //?? "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYW5ib25ha2kuYmFhZGhhbi5jb21cL2FwaVwvdmVuZG9yLXJlZ2lzdHJhdGlvblwvcGhvbmUiLCJpYXQiOjE2MTI5NjI5NDUsImV4cCI6Mzc3Mjk2Mjk0NSwibmJmIjoxNjEyOTYyOTQ1LCJqdGkiOiJXYUJNZkNxazMwZzN0bFNOIiwic3ViIjo4LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Vm_s19r-cs73lsuG7hkSiJYSkMekELFVG19grkYnhrg";
  }

  String getLoginTokenAsToken() {
    // SharedPreferences _sp = await SharedPreferences.getInstance();

    return sp.getString(AppLocalKey.token) ?? '';
  }

  getProviderId() {
    return 1;
  }
}
