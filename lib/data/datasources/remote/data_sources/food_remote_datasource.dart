
import 'package:flutter_application_1/core/resources/app_result.dart';
import 'package:flutter_application_1/data/models/food_model.dart';

abstract class FoodRemoteDataSource {
  Future<AppResult<FoodModel>> getFoods();
  Future<AppResult<FoodModel>> updateFoods();

}