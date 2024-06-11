import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/app.dart';
import 'package:flutter_application_1/src/weatherReport.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stringProvider = Provider<String>((ref) {
  return "hello world";
});

final counterStateProvider = StateProvider((ref) => 0);


final weatherFutureProvider = FutureProvider((ref) => fetchWeatherReport());



void main() {
  runApp(const ProviderScope(child: FoodApp()));
}
