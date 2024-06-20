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
      : super(const FoodListState());

  Future<void> fetchFoods() async {
    state = state.copyWith(status: HomeStatus.loading);
    // await Future.delayed(Duration(seconds: 1));
    try {
      List<FoodEntity> response = await getFoodsUsecase.call(NoParams());
      state = state.copyWith(
          foods: response,
          status: response == [] ? HomeStatus.empty : HomeStatus.success);
    } catch (e) {
      state = state.copyWith(error: e.toString(), status: HomeStatus.failure);
    }
  }

  void searchFoods(String query) async {
    state = state.copyWith(searchStatus: HomeStatus.loading);
    try {
      if (query == '') {
        state =
            state.copyWith(searchfoods: [], searchStatus: HomeStatus.initial);
      } else {
        List<FoodEntity>? filteredFoods = state.foods
            ?.where(
                (food) => food.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        state = state.copyWith(
            searchfoods: filteredFoods,
            searchStatus: filteredFoods == null || filteredFoods.isEmpty
                ? HomeStatus.empty
                : HomeStatus.success);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), status: HomeStatus.failure);
    }
  }

  Future<void> filterFoodsByCategory(String category) async {
    state = state.copyWith(status: HomeStatus.loading);
    // await Future.delayed(Duration(seconds: 1));

    try {
      final filteredFoods = state.foods
          ?.where((food) =>
              food.name.toLowerCase().contains(category.toLowerCase()))
          .toList();
      state = state.copyWith(
          filterfoods: filteredFoods,
          status: filteredFoods == null || filteredFoods.isEmpty
              ? HomeStatus.empty
              : HomeStatus.success);
    } catch (e) {
      state = state.copyWith(error: e.toString(), status: HomeStatus.failure);
    }
  }
}
