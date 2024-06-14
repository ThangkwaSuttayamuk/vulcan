import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/repositories/cart_repository.dart';

class AddToCartUsecase implements UseCase<void, AddToCartUsecaseTypeParam> {
  final CartRepository repository;

  AddToCartUsecase(this.repository);
  
  @override
  Future<void> call(AddToCartUsecaseTypeParam params) async {
    await repository.addToCart(params.foodId,params.quantity);
  }
}
class AddToCartUsecaseTypeParam {
  final int foodId;
  final int quantity;

  const AddToCartUsecaseTypeParam(this.foodId, this.quantity);
}
