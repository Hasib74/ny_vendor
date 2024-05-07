import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:single_vendor_admin/core/Notification/Model/Response.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HomePage/VendorHomePage.dart';

import '../../utils/global_variables.dart';

class NotificationService {
  static String _server_key =
      "AAAA1__WnW4:APA91bEGw8ZRcMUo-V1Ovt3N6XI5AUkzWkbdhVmHx79doyC7GbffIMIKaPKI6yqv1MhwBv0eEzDy88YU7mSgbwV5WxffGBoPLA1aYpPZvYkgKkl2bhgMwrq5L83cQ1RWVmrBtkNL9lyf";
  static String _url = " https://fcm.googleapis.com/fcm/send";

  Future<void> initializeLocalNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    // app_icon needs to be a added as a drawable resource to the
    // Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
  }

/*
  static Future<NotificationResponse> sendNotification(body) async {
    Map<String, String> _header = {
      "Authorization": "key=${_server_key}",
      "Content-Type": "application/json"
    };
    var _response =
    await http.post(Uri.parse(_url), headers: _header, body: body);
    return NotificationResponse.fromJson(jsonDecode(_response.body));
  }*/

/*  static listenNotificationMessage() {

    ///FirebaseMessaging.onMessage.
    FirebaseMessaging.onMessage.listen((event) {
      print(
          "Event : body  ${event.notification!.body} title : ${event.notification!.title}");
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      List list = List.generate(16, (i) => i);
      flutterLocalNotificationsPlugin.show(
          list[0],
          event.notification!.title,
          event.notification!.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                list[1].toString(),
                list[0].toString(),
                icon: "@mipmap/launcher_icon",
              )),
          payload: _clickAction());
    });
  }

  static listenBackgroundNotificationMessage() {
    try {
      FirebaseMessaging.onBackgroundMessage((message) async {
        FlutterLocalNotificationsPlugin
        flutterLocalNotificationsPlugin = // print(
        //     "Event : body  background  ${message.notification!.body} title : ${message.notification!.title}");
        FlutterLocalNotificationsPlugin();
        List list = List.generate(16, (i) => i);
        flutterLocalNotificationsPlugin.show(
            list[0],
            message.notification!.title,
            message.notification!.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  list[1],
                  list[0].toString(),
                  icon: "@mipmap/launcher_icon",
                )),
            payload: _clickAction());

        //  return null;
      });
    } on Exception catch (e) {
      // TODO
    }
  }

  static listenForgroundNotificationMessage() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print(
          "Event : body on Open message ::  ${event.notification!.body} title : ${event.notification!.title}");
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      List list = List.generate(16, (i) => i);
      flutterLocalNotificationsPlugin.show(
          list[0],
          event.notification!.title,
          event.notification!.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                list[1].toString(),
                list[0].toString(),
                icon: "@mipmap/launcher_icon",
              )),
          payload: _clickAction());
    });
  }

  static _clickAction() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero).then((value) {
        Navigator.of(GlobalVariable.navState.currentContext!)
            .push(MaterialPageRoute(
            builder: (context) => VendorHomePage(
              isNotification: true,
            )));
      });
    });
  }*/
}

listenNotificationMessage() {
  ///FirebaseMessaging.onMessage.
  FirebaseMessaging.onMessage.listen((event) {
    print(
        "Event : body  broadcast  ${event.notification!.body} title : ${event.notification!.title}");
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    List list = List.generate(16, (i) => i);

    _showLocalNotification(event.notification?.title ?? "", event.notification?.body??"", event.data!);
    flutterLocalNotificationsPlugin.show(
      list[0],
      event.notification!.title,
      event.notification!.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
        list[1].toString(),
        list[0].toString(),
        icon: "@mipmap/launcher_icon",
      )),
    );
  });
}

listenBackgroundNotificationMessage() {
  try {
    FirebaseMessaging.onBackgroundMessage((message) async {
      print(
          "Event : body  onBackgroundMessage  ${message.notification!.body} title : ${message.notification!.title}");

      FlutterLocalNotificationsPlugin
          flutterLocalNotificationsPlugin = // print(
          //     "Event : body  background  ${message.notification!.body} title : ${message.notification!.title}");
          FlutterLocalNotificationsPlugin();
      List list = List.generate(16, (i) => i);

      _showLocalNotification(message.notification?.title ?? "", message.notification?.body??"", message.data!);

      flutterLocalNotificationsPlugin.show(
        list[0],
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          list[1],
          list[0].toString(),
          icon: "@mipmap/launcher_icon",
        )),
      );

      //  return null;
    });
  } on Exception catch (e) {
    // TODO
  }
}

listenForgroundNotificationMessage() {
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(
        "Event : body on Open message ::  ${event.notification!.body} title : ${event.notification!.title}");
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    List list = List.generate(16, (i) => i);


    _showLocalNotification(event.notification?.title ?? "", event.notification?.body??"", event.data!);

    flutterLocalNotificationsPlugin.show(
      list[0],
      event.notification!.title,
      event.notification!.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
        list[1].toString(),
        list[0].toString(),
        icon: "@mipmap/launcher_icon",
      )),
    );
  });
}

_clickAction() {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    Future.delayed(Duration.zero).then((value) {
      Navigator.of(GlobalVariable.navState.currentContext!)
          .push(MaterialPageRoute(
              builder: (context) => VendorHomePage(
                    isNotification: true,
                  )));
    });
  });
}

void _showLocalNotification(
    String title, String body, Map<String, dynamic> data) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.max,
    icon: '@mipmap/launcher_icon',
  );
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await FlutterLocalNotificationsPlugin().show(
    0,
    title,
    body,
    platformChannelSpecifics,
    payload: data.toString(), // Pass data payload as notification payload
  );
}
