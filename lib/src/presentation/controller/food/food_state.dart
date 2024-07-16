import 'package:flutter_application_1/src/domain/entities/food_entity.dart';

enum HomeStatus { initial, loading, success, failure, empty }

class FoodListState {
  final HomeStatus status;
  final HomeStatus searchStatus;
  final HomeStatus filterStatus;
  final bool showBanner;
  final FoodEntity? foodById;
  final List<FoodEntity>? foods;
  final List<FoodEntity>? filterfoods;
  final List<FoodEntity>? searchfoods;

  final String? error;

  const FoodListState({
    this.status = HomeStatus.initial,
    this.searchStatus = HomeStatus.initial,
    this.filterStatus = HomeStatus.initial,
    this.showBanner = true,
    this.foodById,
    this.foods,
    this.filterfoods,
    this.searchfoods,
    this.error,
  });

  FoodListState copyWith({
    HomeStatus? status,
    HomeStatus? searchStatus,
    HomeStatus? filterStatus,
    bool? showBanner,
    FoodEntity? foodById,
    List<FoodEntity>? foods,
    List<FoodEntity>? filterfoods,
    List<FoodEntity>? searchfoods,
    String? error,
  }) {
    return FoodListState(
      status: status ?? this.status,
      searchStatus: searchStatus ?? this.searchStatus,
      filterStatus: filterStatus ?? this.filterStatus,
      showBanner: showBanner ?? this.showBanner,
      foodById: foodById ?? this.foodById,
      foods: foods ?? this.foods,
      filterfoods: filterfoods ?? this.filterfoods,
      searchfoods: searchfoods ?? this.searchfoods,
      error: error ?? this.error,
    );
  }
}
