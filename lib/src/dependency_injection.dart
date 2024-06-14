import 'package:flutter_application_1/src/domain/usecases/insert_multiple_foods_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/remove_to_cart_usecase.dart';
import 'package:flutter_application_1/src/presentation/bloc/cart_bloc.dart';
import 'package:get_it/get_it.dart';
import 'data/datasources/local/database_helper.dart';
import 'data/repositories/food_repository_impl.dart';
import 'data/repositories/cart_repository_impl.dart';
import 'domain/repositories/food_repository.dart';
import 'domain/repositories/cart_repository.dart';
import 'domain/usecases/get_foods_usecase.dart';
import 'domain/usecases/insert_food.dart';
import 'domain/usecases/add_favorite_usecase.dart';
import 'domain/usecases/remove_favorite_usecase.dart';
import 'domain/usecases/get_all_favorite_usecase.dart';
import 'domain/usecases/get_food_by_id_usecase.dart';
import 'domain/usecases/is_favorite_usecase.dart';
import 'domain/usecases/add_to_cart_usecase.dart';
import 'domain/usecases/get_cart_usecase.dart';
import 'presentation/bloc/food_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Data sources
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // Repositories
  sl.registerLazySingleton<FoodRepository>(() => FoodRepositoryImpl(sl()));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetFoodsUsecase(sl()));
  sl.registerLazySingleton(() => InsertFood(sl()));
  sl.registerLazySingleton(() => InsertMultipleFoodsUsecase(sl()));
  sl.registerLazySingleton(() => AddToFavoritesUsecase(sl()));
  sl.registerLazySingleton(() => RemoveFavoriteUsecase(sl()));
  sl.registerLazySingleton(() => GetAllFavoritesUsecase(sl()));
  sl.registerLazySingleton(() => GetFoodByIdUsecase(sl()));
  sl.registerLazySingleton(() => IsFavoriteUsecase(sl()));
  sl.registerLazySingleton(() => AddToCartUsecase(sl()));
  sl.registerLazySingleton(() => GetCartUsecase(sl()));
  sl.registerLazySingleton(() => RemoveToCartUsecase(sl()));

  // Blocs
  sl.registerFactory(() => FoodBloc(
        getFoods: sl(),
        insertFood: sl(),
        insertMultipleFoods: sl(),
        addToFavorites: sl(),
        removeFavorite: sl(),
        getAllFavorites: sl(),
      ));
  sl.registerFactory(() => CartBloc(
    getCart: sl(),
    addToCart: sl(),
    removeToCart: sl()
  ));
}
