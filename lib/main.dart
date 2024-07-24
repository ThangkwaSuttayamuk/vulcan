import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/app.dart';
import 'package:flutter_application_1/src/data/firebase_notifcation.dart';
import 'package:flutter_application_1/src/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseNotification.registerNotification();
  FirebaseNotification.checkForInitialMessage();
  runApp(const ProviderScope(child: FoodApp()));
}
