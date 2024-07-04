
import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/repositories/cart_repository.dart';


class DeleteFormCartUsecase implements UseCase<void, int> {
  final CartRepository repository;

  DeleteFormCartUsecase(this.repository);

  @override
  Future<void> call(int foodId) async {
    await repository.deleteFoodFromCart(foodId);
  }
}
