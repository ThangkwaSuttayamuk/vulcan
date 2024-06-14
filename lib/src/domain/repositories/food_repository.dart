import 'package:flutter_application_1/src/domain/entities/food_entity.dart';

abstract class FoodRepository {
  
  Future<void> insertFood(FoodEntity food);
  Future<void> insertMultipleFoods(List<FoodEntity> foods);
  Future<List<FoodEntity>> getFoods();
  Future<FoodEntity> getFoodById(int id);
  Future<List<FoodEntity>> getAllFavorites();
  Future<void> addToFavorites(int foodId);
  Future<void> removeFavorite(int foodId);
  Future<bool> isFavorite(int foodId);
}