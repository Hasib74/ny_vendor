import 'package:get/get.dart';

class VendorDrawerController extends GetxController {
  static VendorDrawerController to = Get.find();

  RxBool isOpenKitchen = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
