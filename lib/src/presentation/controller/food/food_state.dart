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

