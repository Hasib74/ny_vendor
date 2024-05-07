import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/core/Notification/NotificationService/NotificationService.dart';
import 'package:single_vendor_admin/core/network/network_info.dart';
import 'package:single_vendor_admin/data/repository/Local/DataSource/MySharedPreference.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/TokenController.dart';
import 'package:single_vendor_admin/presentation/Controller/AppMood/AppMood.dart';
import 'package:single_vendor_admin/presentation/Controller/AppMood/AppMoodController.dart';
import 'package:single_vendor_admin/presentation/Language/Language-en.dart';
import 'package:single_vendor_admin/presentation/Routes/AppsRoutes.dart';
import 'package:single_vendor_admin/presentation/Screen/SplashScreen/Controller/SplashScreenController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Banner/controller/banner_controller.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Controller/ProfileController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/CredentialInformation/Controller/CredentialChnagedPasswordController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/CredentialInformation/Controller/CredentialInformationController.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/DeliveryMan/Controller/delivery_man_controller.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/OrderPickedItem/Controller/OrderItemsPickedController.dart';
import 'core/utils/global_variables.dart';
//import 'firebase_options.dart';

Language language = Language();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
   // options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationService().initializeLocalNotifications();
  listenNotificationMessage();
  listenForgroundNotificationMessage();
  listenBackgroundNotificationMessage();
  runApp(Phoenix(child: MyApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the background message here
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(
      MySharedPreferenceController(),
    );
    Get.put(NetworkInfoController(), permanent: true);
    Get.put(AppMoodController()).setAppMood(AppMood.DEMO);
    Get.put(TokenController(), permanent: true);
    Get.lazyPut(
      () => SplashScreenController(),
    );
    Get.put(ProfileController(), permanent: true);
    Get.put(OrderItemsPickedController(), permanent: true);
    Get.put(CredentialInformationController(), permanent: true);
    Get.put(CredentialChangedPasswordController(), permanent: true);
    Get.put(AppDeliveryManController(), permanent: true);
    Get.put(BannerController(), permanent: true);

    return GetMaterialApp(
      navigatorKey: GlobalVariable.navState,
      debugShowCheckedModeBanner: false,
      title: language.runner_food,
      getPages: AppRoutes.AppRoutesList(),
      initialRoute: AppRoutes.INITIAL,
    );
  }
}
