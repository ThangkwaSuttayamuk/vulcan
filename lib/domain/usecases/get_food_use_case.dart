import 'package:flutter_application_1/core/resources/app_result.dart';
import 'package:flutter_application_1/domain/entities/food_entity.dart';
import 'package:flutter_application_1/domain/repositories/food_repository.dart';

import '../../core/usecases/usecase.dart';

class GetFoodUseCase implements UseCase<AppResult<FoodEntity>, void>{
  final FoodRepository foodRepository;

  GetFoodUseCase({required this.foodRepository});

  @override
  Future<AppResult<FoodEntity>> call(void params) {
    return foodRepository.getFoods();
  }
}

