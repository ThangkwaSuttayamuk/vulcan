import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/entities/food_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/food_repository.dart';

class GetFoodsUsecase implements UseCase<List<FoodEntity>, NoParams> {
  final FoodRepository repository;

  GetFoodsUsecase(this.repository);

  @override
  Future<List<FoodEntity>> call(NoParams  noParams) async {
    return await repository.getFoods();
  }
}
