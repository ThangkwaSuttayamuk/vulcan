import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1/src/app.dart';
import 'package:flutter_application_1/src/domain/entities/push_notification_entity.dart';
import 'package:flutter_application_1/src/presentation/controller/notification/notification_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';

class FirebaseNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  static Future<void> registerNotification() async {
    await Firebase.initializeApp();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        Map<String, dynamic> notificationPayload =
            (jsonDecode(notificationResponse.payload!));

        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            print(
                'message receive when open the app and the action will be trigger when click this message');
            navigatorKey.currentState
                ?.pushNamed('/notification_detail', arguments: {
              "id": notificationPayload['id'],
              "title": notificationPayload['title'],
              "period": notificationPayload['period'],
              "description": notificationPayload['description'],
              "image": notificationPayload['image']
            });
            break;
          case NotificationResponseType.selectedNotificationAction:
            print(
                'message receive when close the app and the action will be trigger when click this message');
            //trigger when the app is on the background, open (message type => not local)
            navigatorKey.currentState?.pushNamed('/setting');
            print(notificationPayload['id']);

            // if (notificationResponse.actionId == navigationActionId) {
            //   selectNotificationStream.add(notificationResponse.payload);
            // }
            break;
        }
      },
    );

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp
        .listen(firebaseOnMessageOpenAppHandler);

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message Title: ${message.notification?.title}');
        PushNotificationEntity notification = PushNotificationEntity(
            title: message.notification?.title ?? '',
            body: message.notification?.body ?? '',
            dataTitle: message.data['title'] ?? '',
            dataBody: message.data['data'] ?? '');

        showLocalNotification(notification.title, notification.body ?? '',
            jsonEncode(message.data));
      });
    }
  }

  static Future<void> showLocalNotification(
      String title, String body, dynamic data) async {
    const androidNotificationDetail = AndroidNotificationDetails(
      '0',
      'general',
      priority: Priority.high,
      autoCancel: false,
      fullScreenIntent: true,
      enableVibration: true,
      importance: Importance.high,
      playSound: true,
    );

    const iosNotificatonDetail = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      iOS: iosNotificatonDetail,
      android: androidNotificationDetail,
    );

    flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails,
        payload: data);
  }

  static Future<void> checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotificationEntity notification = PushNotificationEntity(
        title: initialMessage.notification?.title ?? '',
        body: initialMessage.notification?.body ?? '',
        dataTitle: initialMessage.data['title'] ?? '',
        dataBody: initialMessage.data['body'] ?? '',
        // navigator: initialMessage.data['navigator'] ?? ''
      );
    }
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    final ref = ProviderContainer();
    ref.read(notificationProvider.notifier).addNotification(
        message.data['title'],
        message.data['period'],
        message.data['description'],
        message.data['image']);

    // if (initialMessage != null) {
    //   PushNotificationEntity notification = PushNotificationEntity(
    //     title: initialMessage.notification?.title ?? '',
    //     body: initialMessage.notification?.body ?? '',
    //     dataTitle: initialMessage.data['title'] ?? '',
    //     dataBody: initialMessage.data['body'] ?? '',
    //   );
    // }
  }

  static Future<void> firebaseOnMessageOpenAppHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    print('open app after click message that sent on background');

    navigatorKey.currentState?.pushNamed('/notification_detail', arguments: {
      "id": message.data['id'],
      "title": message.data['title'],
      "period": message.data['period'],
      "description": message.data['description'],
      "image": message.data['image']
    });
  }
}
