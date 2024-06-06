import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/login/login_page.dart';

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "FoodApp", home: LoginPage());
  }
}
