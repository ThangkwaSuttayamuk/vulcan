import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/entities/food_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/food_repository.dart';

class InsertMultipleFoodsUsecase implements UseCase<void, List<FoodEntity>> {
  final FoodRepository repository;

  InsertMultipleFoodsUsecase(this.repository);
  
  @override
  Future<void> call(List<FoodEntity> foods) async {
    await repository.insertMultipleFoods(foods);
  }
}
