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

  //For Handling the Notification in Terminated State
  FirebaseNotification.checkForInitialMessage();

  //For Handling the Notification when app is in background but not terminated
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("onMessageOpenedApp");
    PushNotificationEntity notification = PushNotificationEntity(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      dataTitle: message.data['title'] ?? '',
      dataBody: message.data['body'] ?? ''
    );
    print("Notification Title: ${notification.title}");
    print("Notification Body: ${notification.body}");
    print("Notification Data Title: ${notification.dataTitle}");
    print("Notification Data Body: ${notification.dataBody}");

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
