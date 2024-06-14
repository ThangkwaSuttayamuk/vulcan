import 'package:flutter_application_1/src/core/usecase/usecase.dart';

import '../repositories/food_repository.dart';

class RemoveFavoriteUsecase implements UseCase<void, int> {
  final FoodRepository repository;

  RemoveFavoriteUsecase(this.repository);

  @override
  Future<void> call(int foodId) async {
    await repository.removeFavorite(foodId);
  }
}
