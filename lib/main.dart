import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/app.dart';
import 'package:flutter_application_1/src/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  init();
  runApp(const ProviderScope(child: FoodApp()));
}
