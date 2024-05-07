import 'package:get/get.dart';
import 'package:single_vendor_admin/data/repository/Local/DataSource/MySharedPreference.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/TokenController.dart';
import 'package:single_vendor_admin/presentation/Controller/AppLoading/AppLoadingController.dart';
import 'package:single_vendor_admin/presentation/Routes/AppsRoutes.dart';
import 'package:single_vendor_admin/presentation/Screen/AppSetting/About/AboutScreenController.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/AccountRecovery/Controller/AccountRecoveryController.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/Controller/AuthenticationController.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/OTP/Controller/OtpController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddAddress/Controller/AddAddressController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HomePage/Controller/VendorHomePageController.dart';

MySharedPreferenceController _mySharedPreferenceController = Get.find();

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    print('loading app from splash_screen');
    _loadDependacy().then((value) => loadData());
  }

  void loadData() async {
    // Get.put(ProfileController());

    new Future.delayed(const Duration(seconds: 2), () async {
      String value = _mySharedPreferenceController.getLoginToken();
      // print("Token is  ::  ${value}");

      if (value == "" || value == null) {
        printInfo(info: "Token is null");

        _navigateToLogin();
      } else {
        TokenController.to.token = value;

        printInfo(info: "Token is ${TokenController.to.token}");

        Future.delayed(Duration(seconds: 5), () async {
          await ProfileController.to.getVendorProfile();

          _navigateToHome();
        });
      }
    });
  }

  void _navigateToHome() {
    Get.offAllNamed(AppRoutes.VENDOR_HOME_PAGE);
  }

  void _navigateToLogin() {
    Get.offAllNamed(AppRoutes.LOG_IN);
  }

  Future _loadDependacy() async {
    await Get.put(ProfileController(), permanent: true);
    await Get.put(AppLoadingController(), permanent: true);
    await Get.put(AuthenticationController(), permanent: true);

    Get.lazyPut(() => AccountRecoveryController());
    Get.lazyPut(() => AddAddressController());
    Get.lazyPut(() => VendorHomePageController());
    Get.lazyPut(() => OtpController());
    Get.lazyPut(() => AboutScreenController());

    return;
  }
}
