import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/entities/order_item_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/order_repository.dart';

class GetOrderListByIdUsecase implements UseCase<List<OrderItemEntity>, int> {
  final OrderRepository repository;

  GetOrderListByIdUsecase(this.repository);

  @override
  Future<List<OrderItemEntity>> call(int id) async {
    return await repository.getOrderListById(id);
  }
}
