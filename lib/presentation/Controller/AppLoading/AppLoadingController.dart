import 'package:get/get.dart';

class AppLoadingController extends GetxController {

  static AppLoadingController to = Get.find() ;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    isLoading = false.obs;
    update();
    super.onInit();
  }



}
