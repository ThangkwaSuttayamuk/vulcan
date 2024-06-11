// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:flutter_application_1/src/domain/entities/food.dart';
// import 'package:flutter_application_1/src/domain/repositories/food_repository.dart';

// class FoodRepositoryImpl implements FoodRepository {

//   @override
//   Future<List<Food>> getAllFoods() async {
//     final jsonString = await rootBundle.loadString('assets/food.json');
//     final List<dynamic> jsonResponse = json.decode(jsonString);
//     print(jsonResponse);
//     print(jsonResponse.map((json) => Food.fromJson(json)).toList());
//     return jsonResponse.map((json) => Food.fromJson(json)).toList();
//   }
// }