import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_state.dart';
import 'package:flutter_application_1/utils/database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteFoodNotifier extends StateNotifier<FavoriteFoodState> {
  FavoriteFoodNotifier() : super(FavoriteFoodState(favoriteFoods: []));
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<void> fetchFavoriteFoods() async {
    state = state.copyWith(isLoading: true);
    try {
      final favoriteFoods = await dbHelper.getAllFavorites();
      state = state.copyWith(favoriteFoods: favoriteFoods, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> addFavorite(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      dbHelper.addToFavorites(id);
      final favoriteFoods = await dbHelper.getAllFavorites();
      state = state.copyWith(favoriteFoods: favoriteFoods);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> removeFavorite(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      dbHelper.removeFavorite(id);
      final favoriteFoods = await dbHelper.getAllFavorites();
      state = state.copyWith(favoriteFoods: favoriteFoods);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
