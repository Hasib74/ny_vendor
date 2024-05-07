import 'package:get/get.dart';

class AppToggleController extends GetxController {
  static AppToggleController to = Get.find();
  RxBool isActive = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    isActive.value = false;
  }

  setToggleStatus(bool status) {
    isActive.value = status;
  }
}
