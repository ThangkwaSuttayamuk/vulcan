import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/repositories/food_repository.dart';

class AddToFavoritesUsecase implements UseCase<void,int>{
  final FoodRepository repository;

  AddToFavoritesUsecase(this.repository);

  @override
  Future<void> call(int foodId) async {
    await repository.addToFavorites(foodId);
  }
}