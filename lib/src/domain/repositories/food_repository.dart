import 'package:flutter_application_1/src/domain/entities/food.dart';

abstract class FoodRepository {
  Future<List<Food>> getAllFoods();
}