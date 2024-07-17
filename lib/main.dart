import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/app.dart';
import 'package:flutter_application_1/src/data/firbase_api.dart';
import 'package:flutter_application_1/src/data/firebase_notifcation.dart';
import 'package:flutter_application_1/src/dependency_injection.dart';
import 'package:flutter_application_1/src/domain/entities/push_notification_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseNotification.registerNotification();

  FirebaseNotification.checkForInitialMessage();

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    PushNotificationEntity notification = PushNotificationEntity(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      dataTitle: message.data['title'] ?? '',
      dataBody: message.data['body'] ?? ''
    );

  });

  // FirebaseApi.initNotification();

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;
  //   if (notification != null && android != null) {
  //     FirebaseApi.showLocalNotification(
  //       notification.title ?? '',
  //       notification.body ?? '',
  //       message.data['payload'] ?? '',
  //     );
  //   }
  // });

  runApp(const ProviderScope(child: FoodApp()));
}
