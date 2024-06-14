import 'package:flutter_application_1/src/data/repositories/food_repository_impl.dart';
import 'package:flutter_application_1/src/dependency_injection.dart';
import 'package:flutter_application_1/src/domain/repositories/food_repository.dart';
import 'package:flutter_application_1/src/domain/usecases/is_favorite_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite/favorite_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite/favorite_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final foodRepositoryProvider = Provider<FoodRepository>((ref)=>FoodRepositoryImpl(sl()));

final isFavorite = Provider((ref)=>IsFavoriteUsecase(ref.read(foodRepositoryProvider)));

final favoriteProvider =
    StateNotifierProvider.autoDispose<FavoriteNotifier, FavoriteState>((ref) {
  return FavoriteNotifier(ref.read(isFavorite));
});
