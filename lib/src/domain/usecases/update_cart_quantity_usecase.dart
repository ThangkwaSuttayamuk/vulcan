import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/repositories/cart_repository.dart';

class UpdateCartQuantityUsecase
    implements UseCase<void, UpdateCartQuantityUsecaseTypeParam> {
  final CartRepository repository;

  UpdateCartQuantityUsecase(this.repository);

  @override
  Future<void> call(UpdateCartQuantityUsecaseTypeParam params) async {
    await repository.updateCartQuantity(params.foodId, params.newQuantity);
  }
}

class UpdateCartQuantityUsecaseTypeParam {
  final int foodId;
  final int newQuantity;

  const UpdateCartQuantityUsecaseTypeParam(this.foodId, this.newQuantity);
}
