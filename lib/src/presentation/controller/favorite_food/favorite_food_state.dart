import 'package:flutter_application_1/src/domain/entities/food.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteFoodState {
  final List<Food> favoriteFoods;
  final bool isLoading;
  final String? error;

  FavoriteFoodState({
    required this.favoriteFoods,
    this.isLoading = false,
    this.error,
  });

  FavoriteFoodState copyWith({
    List<Food>? favoriteFoods,
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
