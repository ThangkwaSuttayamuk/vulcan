import 'package:flutter_application_1/src/domain/entities/food_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteFoodState {
  final List<FoodEntity> favoriteFoods;
  final bool isLoading;
  final String? error;

  FavoriteFoodState({
    required this.favoriteFoods,
    this.isLoading = false,
    this.error,
  });

  FavoriteFoodState copyWith({
    List<FoodEntity>? favoriteFoods,
    bool? isLoading,
    String? error,
  }) {
    return FavoriteFoodState(
      favoriteFoods: favoriteFoods ?? this.favoriteFoods,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
