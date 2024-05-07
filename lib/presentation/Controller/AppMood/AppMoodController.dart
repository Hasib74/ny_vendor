import 'package:single_vendor_admin/presentation/Controller/AppMood/AppMood.dart';
import 'package:get/get.dart';

class AppMoodController extends GetxController {
  AppMood? appMood;

  setAppMood(AppMood appMood) {
    this.appMood = appMood;
    update();
  }
}
