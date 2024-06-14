import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/entities/food_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/food_repository.dart';

class GetFoodByIdUsecase implements UseCase<FoodEntity,int >{
  final FoodRepository repository;

  GetFoodByIdUsecase(this.repository);

  @override
  Future<FoodEntity> call(int id) async {
    return await repository.getFoodById(id);
  }
}