import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/domain/entities/food.dart';
import 'package:flutter_application_1/utils/database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodListState {
  final List<Food> foods;
  final bool isLoading;
  final String? error;

  FoodListState({required this.foods, this.isLoading = false, this.error});

  FoodListState copyWith({
    List<Food>? foods,
    bool? isLoading,
    String? error,
  }) {
    return FoodListState(
      foods: foods ?? this.foods,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

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

final foodListProvider =
    StateNotifierProvider.autoDispose<FoodListNotifier, FoodListState>((ref) {
  return FoodListNotifier();
});
