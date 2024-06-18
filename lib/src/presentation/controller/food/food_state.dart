import 'package:flutter_application_1/src/domain/entities/food_entity.dart';

enum HomeStatus { initial, loading, success, failure, empty }


class FoodListState {
  final HomeStatus status;
  final HomeStatus searchStatus;
  final List<FoodEntity>? foods;
  final List<FoodEntity>? filterfoods;
  final List<FoodEntity>? searchfoods;

  final String? error;

  const FoodListState({
    this.status = HomeStatus.initial,
    this.searchStatus = HomeStatus.initial,
    this.foods,
    this.filterfoods,
    this.searchfoods,
    this.error,
  });

  FoodListState copyWith({
    HomeStatus? status,
    HomeStatus? searchStatus,
    List<FoodEntity>? foods,
    List<FoodEntity>? filterfoods,
    List<FoodEntity>? searchfoods,
    String? error,
  }) {
    return FoodListState(
      status: status ?? this.status,
      searchStatus: searchStatus ?? this.searchStatus,
      foods: foods ?? this.foods,
      filterfoods: filterfoods ?? this.filterfoods,
      searchfoods: searchfoods ?? this.searchfoods,
      error: error ?? this.error,
    );
  }
}
