import 'package:flutter_application_1/src/data/repositories/notification_repository_impl.dart';
import 'package:flutter_application_1/src/data/repositories/order_repository_impl.dart';
import 'package:flutter_application_1/src/data/repositories/user_repository_impl.dart';
import 'package:flutter_application_1/src/domain/repositories/notification_repository.dart';
import 'package:flutter_application_1/src/domain/repositories/order_repository.dart';
import 'package:flutter_application_1/src/domain/repositories/user_repository.dart';
import 'package:flutter_application_1/src/domain/usecases/add_notification_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/add_order_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/delete_form_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_notification_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_order_list_by_id.dart';
import 'package:flutter_application_1/src/domain/usecases/get_order_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_user_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/insert_multiple_foods_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/remove_to_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:flutter_application_1/src/presentation/bloc/cart_bloc.dart';
import 'package:flutter_application_1/src/presentation/bloc/notification_bloc.dart';
import 'package:flutter_application_1/src/presentation/bloc/order_bloc.dart';
import 'package:flutter_application_1/src/presentation/bloc/user_bloc.dart';
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
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(sl()));

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
  sl.registerLazySingleton(() => DeleteFormCartUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCartQuantityUsecase(sl()));
  sl.registerLazySingleton(() => AddOrderUsecase(sl()));
  sl.registerLazySingleton(() => GetOrderUsecase(sl()));
  sl.registerLazySingleton(() => GetOrderListByIdUsecase(sl()));
  sl.registerLazySingleton(() => GetUserUsecase(sl()));
  sl.registerLazySingleton(() => AddNotificationUsecase(sl()));
  sl.registerLazySingleton(() => GetNotificationUsecase(sl()));

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
      removeToCart: sl(),
      deleteFormCartUsecase: sl(),
      updateCartQuantityUsecase: sl()));
  sl.registerFactory(() => OrderBloc(
      addOrderUsecase: sl(),
      getOrderUsecase: sl(),
      getOrderListByIdUsecase: sl()));
  sl.registerFactory(() => UserBloc(getUser: sl()));
  sl.registerFactory(() => NotificationBloc(
      addNotificationUsecase: sl(), getNotificationUsecase: sl()));
}
