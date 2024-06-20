import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/entities/order_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/order_repository.dart';

class GetOrderUsecase implements UseCase<List<OrderEntity>, NoParams> {
  final OrderRepository repository;
  GetOrderUsecase(this.repository);

  @override
  Future<List<OrderEntity>> call(NoParams noParams) async {
    return await repository.getOrders();
  }
}
