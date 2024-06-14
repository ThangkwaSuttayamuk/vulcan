
import 'package:flutter_application_1/src/domain/repositories/food_repository.dart';
import 'package:flutter_application_1/src/data/repositories/food_repository_impl.dart';
import 'package:flutter_application_1/src/dependency_injection.dart';

import 'package:flutter_application_1/src/domain/usecases/get_foods_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/insert_multiple_foods_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final foodRepositoryProvider = Provider<FoodRepository>((ref)=>FoodRepositoryImpl(sl()));


final getFoods = Provider((ref)=>GetFoodsUsecase(ref.read(foodRepositoryProvider)));

final insertMultipleFoods = Provider((ref)=>InsertMultipleFoodsUsecase(ref.read(foodRepositoryProvider)));


final foodListProvider =
    StateNotifierProvider.autoDispose<FoodListNotifier, FoodListState>((ref) {
  return FoodListNotifier(
    ref.read(getFoods),
    ref.read(insertMultipleFoods)
  );
});