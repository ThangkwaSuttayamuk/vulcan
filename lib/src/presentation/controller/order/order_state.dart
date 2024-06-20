import 'package:flutter_application_1/src/domain/entities/order_entity.dart';

enum OrderStatus { initial, loading, success, failure, empty }

class OrderState {
  final List<OrderEntity>? orderList;
  final OrderStatus status;
  final String? error;

  OrderState({
    this.orderList,
    this.status = OrderStatus.initial,
    this.error,
  });

  OrderState copyWith(
      {List<OrderEntity>? orderList, String? error, OrderStatus? status}) {
    return OrderState(
        orderList: orderList ?? this.orderList,
        error: error ?? this.error,
        status: status ?? this.status);
  }
}
