import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/repositories/order_repository.dart';

class AddOrderUsecase implements UseCase<void, AddOrderUsecaseTypeParam> {
  final OrderRepository repository;

  AddOrderUsecase(this.repository);

  @override
  Future<void> call(AddOrderUsecaseTypeParam params) async {
    await repository.addOrderFromCart(params.address, params.tel);
  }
}

class AddOrderUsecaseTypeParam {
  final String address;
  final String tel;

  const AddOrderUsecaseTypeParam(this.address, this.tel);
}
