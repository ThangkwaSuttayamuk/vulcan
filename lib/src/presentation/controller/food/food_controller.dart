import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/entities/food_entity.dart';
import 'package:flutter_application_1/src/domain/usecases/get_foods_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/insert_multiple_foods_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodListNotifier extends StateNotifier<FoodListState> {
  final GetFoodsUsecase getFoodsUsecase;
  final InsertMultipleFoodsUsecase insertMultipleFoodsUsecase;

  FoodListNotifier(this.getFoodsUsecase, this.insertMultipleFoodsUsecase)
      : super(FoodListState(
          foods: [],
        ));

  Future<void> fetchFoods() async {
    state = state.copyWith(isLoading: true);
    try {
      String jsonString = await rootBundle.loadString('assets/food.json');
      List<dynamic> jsonData = jsonDecode(jsonString);
      List<FoodEntity> foodList = jsonData.map((item) {
        return FoodEntity.fromJson(item);
      }).toList();
      await insertMultipleFoodsUsecase(foodList);
      List<FoodEntity> response = await getFoodsUsecase.call(NoParams());
      state = state.copyWith(foods: response, isLoading: false);
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
      fetchFoods();
    } else {
      final filteredFoods = state.foods
          .where((food) =>
              food.name.toLowerCase().contains(category.toLowerCase()))
          .toList();
      state = state.copyWith(foods: filteredFoods);
    }
  }
}
