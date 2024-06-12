import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteFoodProvider =
    StateNotifierProvider.autoDispose<FavoriteFoodNotifier, FavoriteFoodState>(
        (ref) {
  return FavoriteFoodNotifier();
});