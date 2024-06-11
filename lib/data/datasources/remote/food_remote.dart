import 'dart:convert';

import 'package:flutter_application_1/core/resources/app_result.dart';
import 'package:flutter_application_1/core/resources/data_state.dart';

import '../../../constants/stub_constants.dart';
import '../../../utils/mock_client_util.dart';
import '../../models/food_model.dart';
import 'data_sources/food_remote_datasource.dart';

class FoodRemote implements FoodRemoteDataSource{
  @override
  Future<AppResult<FoodModel>> getFoods() async {
    try {
      var res = await MockClientUtils().mock(StubConstants.food);
      Map<String,dynamic> userMap = jsonDecode(res.body);
      // FoodModel.fromJson(userMap);
      return Success(value: FoodModel.fromJson(userMap));
    } catch(e){
      return Error(errorObject: e);
    }
  }

  @override
  Future<AppResult<FoodModel>> updateFoods() {
    // TODO: implement updateFoods
    throw UnimplementedError();
  }
}