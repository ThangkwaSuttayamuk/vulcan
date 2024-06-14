import 'package:flutter_application_1/src/domain/entities/food_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/food_repository.dart';

class InsertFood {
  final FoodRepository repository;

  InsertFood(this.repository);

  Future<void> call(FoodEntity food) async {
    await repository.insertFood(food);
  }
}