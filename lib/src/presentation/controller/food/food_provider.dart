
import 'package:flutter_application_1/src/presentation/controller/food/food_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final foodListProvider =
    StateNotifierProvider.autoDispose<FoodListNotifier, FoodListState>((ref) {
  return FoodListNotifier();
});