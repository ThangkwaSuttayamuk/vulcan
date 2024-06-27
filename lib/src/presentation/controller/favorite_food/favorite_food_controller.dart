import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/add_favorite_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_all_favorite_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/remove_favorite_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteFoodNotifier extends StateNotifier<FavoriteFoodState> {
  final AddToFavoritesUsecase addToFavoritesUsecase;
  final GetAllFavoritesUsecase getAllFavoritesUsecase;
  final RemoveFavoriteUsecase removeFavoriteUsecase;

  FavoriteFoodNotifier(this.addToFavoritesUsecase, this.getAllFavoritesUsecase,
      this.removeFavoriteUsecase)
      : super(FavoriteFoodState(favoriteFoods: []));

  Future<void> fetchFavoriteFoods() async {
    state = state.copyWith(status: FavoriteFoodStatus.loading);
    await Future.delayed(const Duration(seconds: 1));

    try {
      final favoriteFoods = await getAllFavoritesUsecase.call(NoParams());
      state = state.copyWith(
          favoriteFoods: favoriteFoods,
          status: favoriteFoods.isEmpty
              ? FavoriteFoodStatus.empty
              : FavoriteFoodStatus.success);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> addFavorite(int id) async {
    try {
      await addToFavoritesUsecase.call(id);
      final favoriteFoods = await getAllFavoritesUsecase.call(NoParams());
      state = state.copyWith(
          favoriteFoods: favoriteFoods,
          status: favoriteFoods.isEmpty
              ? FavoriteFoodStatus.empty
              : FavoriteFoodStatus.success);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> removeFavorite(int id) async {
    try {
      await removeFavoriteUsecase.call(id);
      final favoriteFoods = await getAllFavoritesUsecase.call(NoParams());
      state = state.copyWith(
          favoriteFoods: favoriteFoods,
          status: favoriteFoods.isEmpty
              ? FavoriteFoodStatus.empty
              : FavoriteFoodStatus.success);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
