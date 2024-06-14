import 'package:flutter_application_1/src/domain/entities/food_entity.dart';

enum HomeStatus { initial, loading, success, failure, empty }

class FoodListState {
  final List<FoodEntity> foods;
  final bool isLoading;
  final String? error;

  FoodListState({required this.foods, this.isLoading = false, this.error});

  FoodListState copyWith({
    List<FoodEntity>? foods,
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
