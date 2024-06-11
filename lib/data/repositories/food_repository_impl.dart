import 'package:flutter_application_1/core/resources/app_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/food_entity.dart';
import '../../domain/repositories/food_repository.dart';
import '../datasources/remote/data_sources/food_remote_datasource.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodRemoteDataSource foodRemoteDataSource;

  FoodRepositoryImpl({required this.foodRemoteDataSource});

  @override
  Future<AppResult<FoodEntity>> getFoods() {
    return foodRemoteDataSource.getFoods();
  }

  @override
  Future<AppResult<FoodEntity>> updateFoods() {
    return foodRemoteDataSource.updateFoods();
  }
}
