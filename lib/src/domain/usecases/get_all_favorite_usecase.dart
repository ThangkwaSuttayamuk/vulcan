// domain/usecases/get_all_favorites.dart
import 'package:flutter_application_1/src/core/usecase/usecase.dart';

import '../entities/food_entity.dart';
import '../repositories/food_repository.dart';

class GetAllFavoritesUsecase implements UseCase<List<FoodEntity>, NoParams> {
  final FoodRepository repository;

  GetAllFavoritesUsecase(this.repository);

  @override
  Future<List<FoodEntity>> call(NoParams noParams) async {
    return await repository.getAllFavorites();
  }
}
