import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_application_1/utils/database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodListNotifier extends StateNotifier<FoodListState> {
  FoodListNotifier() : super(FoodListState(foods: []));
  final DatabaseHelper dbHelper = DatabaseHelper();
  final TextEditingController inputController = TextEditingController();

  Future<void> fetchFoods() async {
    state = state.copyWith(isLoading: true);
    try {
      final foods = await dbHelper.getFoods();
      state = state.copyWith(foods: foods, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void filterFoods(String query) {
    if (query.isEmpty) {
      fetchFoods();
    } else {
      final filteredFoods = state.foods
          .where(
              (food) => food.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = state.copyWith(foods: filteredFoods);
    }
  }

  void filterFoodsByCategory(String category) {
    if (category == '' || category.isEmpty) {
      print(category);
      fetchFoods();
    } else {
      print(category);
      final filteredFoods = state.foods
          .where((food) =>
              food.name.toLowerCase().contains(category.toLowerCase()))
          .toList();
      state = state.copyWith(foods: filteredFoods);
    }
  }
}
