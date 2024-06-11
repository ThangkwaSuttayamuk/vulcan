import 'package:flutter_application_1/src/domain/entities/food.dart';
import 'package:flutter_application_1/src/domain/repositories/food_repository.dart';

class GetAllFood {
  final FoodRepository repository;

  GetAllFood(this.repository);

  Future<List<Food>> call() async {
    return await repository.getAllFoods();
  }
}
