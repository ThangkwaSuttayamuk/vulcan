import 'package:flutter_application_1/src/domain/entities/food_entity.dart';

enum FavoriteFoodStatus { initial, loading, success, failure, empty }

class FavoriteFoodState {
  final FavoriteFoodStatus status;
  final List<FoodEntity> favoriteFoods;

  final String? error;

  FavoriteFoodState({
    this.status = FavoriteFoodStatus.initial,
    required this.favoriteFoods,
    this.error,
  });

  FavoriteFoodState copyWith({
    FavoriteFoodStatus? status,
    List<FoodEntity>? favoriteFoods,
    String? error,
  }) {
    return FavoriteFoodState(
      status: status ?? this.status,
      favoriteFoods: favoriteFoods ?? this.favoriteFoods,
      error: error ?? this.error,
    );
  }
}
