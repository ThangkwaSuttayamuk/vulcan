import 'package:flutter/material.dart';

import 'presentation/pages/login_page.dart';

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "FoodApp",
        home: LoginPage()
    );
  }
}
