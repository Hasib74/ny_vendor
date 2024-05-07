import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class AboutScreenController extends GetxController {
  String? appVersion, appBuildNumber, appName;

  static AboutScreenController get to => Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAppPackageInformation();
  }

  getAppPackageInformation() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    //String packageName = packageInfo.packageName;
    appVersion = packageInfo.version;
    appBuildNumber = packageInfo.buildNumber;
    update();
    print("App name is " + appName!);
  }
}
