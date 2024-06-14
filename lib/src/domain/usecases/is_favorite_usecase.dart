import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/repositories/food_repository.dart';

class IsFavoriteUsecase implements UseCase<bool,int>{
  final FoodRepository repository;

  IsFavoriteUsecase(this.repository);

  @override
  Future<bool> call(int foodId) async {
    return await repository.isFavorite(foodId);
  }
}