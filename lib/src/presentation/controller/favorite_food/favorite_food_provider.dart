import 'package:flutter_application_1/src/data/repositories/food_repository_impl.dart';
import 'package:flutter_application_1/src/dependency_injection.dart';
import 'package:flutter_application_1/src/domain/repositories/food_repository.dart';
import 'package:flutter_application_1/src/domain/usecases/add_favorite_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_all_favorite_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/remove_favorite_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/is_favorite_usecase.dart';


final favoriteFoodRepositoryProvider =
    Provider<FoodRepository>((ref) => FoodRepositoryImpl(sl()));

final addToFavorite = Provider((ref)=>AddToFavoritesUsecase(ref.read(favoriteFoodRepositoryProvider)));

final getAllFavorite = Provider((ref)=>GetAllFavoritesUsecase(ref.read(favoriteFoodRepositoryProvider)));

final removeFavorite = Provider((ref)=>RemoveFavoriteUsecase(ref.read(favoriteFoodRepositoryProvider)));

final isFavorite = Provider((ref)=>IsFavoriteUsecase(ref.read(favoriteFoodRepositoryProvider)));

final favoriteFoodProvider =
    StateNotifierProvider.autoDispose<FavoriteFoodNotifier, FavoriteFoodState>(
        (ref) {
  return FavoriteFoodNotifier(
    ref.read(addToFavorite),
    ref.read(getAllFavorite),
    ref.read(removeFavorite),
    ref.read(isFavorite)
  );
});
