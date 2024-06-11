import 'package:flutter_application_1/core/resources/app_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/food_entity.dart';

abstract class FoodRepository {
  Future<AppResult<FoodEntity>> getFoods();
  Future<AppResult<FoodEntity>> updateFoods();
}
