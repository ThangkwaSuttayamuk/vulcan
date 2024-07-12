import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/src/app.dart';
import 'package:flutter_application_1/src/data/firbase_api.dart';
import 'package:flutter_application_1/src/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseApi.initNotification();


  await FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.requestPermission();
  await FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(("THIS IS EVENT :: :: $event"));
  });
  runApp(const ProviderScope(child: FoodApp()));
}
