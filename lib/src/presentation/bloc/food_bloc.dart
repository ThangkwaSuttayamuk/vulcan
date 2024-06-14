import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/insert_multiple_foods_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/food_entity.dart';
import '../../domain/usecases/get_foods_usecase.dart';
import '../../domain/usecases/insert_food.dart';
import '../../domain/usecases/add_favorite_usecase.dart';
import '../../domain/usecases/remove_favorite_usecase.dart';
import '../../domain/usecases/get_all_favorite_usecase.dart';

class FoodBloc extends Cubit<List<FoodEntity>> {
  final GetFoodsUsecase getFoods;
  final InsertFood insertFood;
  final InsertMultipleFoodsUsecase insertMultipleFoods;
  final AddToFavoritesUsecase addToFavorites;
  final RemoveFavoriteUsecase removeFavorite;
  final GetAllFavoritesUsecase getAllFavorites;

  FoodBloc({
    required this.getFoods,
    required this.insertFood,
    required this.insertMultipleFoods,
    required this.addToFavorites,
    required this.removeFavorite,
    required this.getAllFavorites,
  }) : super([]);

  void loadFoods() async {
    final foods = await getFoods(NoParams());
    emit(foods);
  }

  void addFood(FoodEntity food) async {
    await insertFood(food);
    loadFoods();
  }

  void addFavorite(int foodId) async {
    await addToFavorites(foodId);
    loadFoods();
  }

  void removeFavorites(int foodId) async {
    await removeFavorite(foodId);
    loadFoods();
  }

  void loadFavorites() async {
    final favorites = await getAllFavorites(NoParams());
    emit(favorites);
  }
}
