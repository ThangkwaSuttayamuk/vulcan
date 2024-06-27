import 'package:flutter_application_1/src/domain/entities/order_entity.dart';
import 'package:flutter_application_1/src/domain/entities/order_item_entity.dart';

enum OrderStatus { initial, loading, success, failure, empty }

class OrderState {
  final List<OrderEntity>? orderList;
  final List<OrderItemEntity>? orderItems;
  final OrderStatus status;
  final String? error;

  OrderState({
    this.orderList,
    this.orderItems,
    this.status = OrderStatus.initial,
    this.error,
  });

  OrderState copyWith(
      {List<OrderEntity>? orderList,
      List<OrderItemEntity>? orderItems,
      String? error,
      OrderStatus? status}) {
    return OrderState(
        orderList: orderList ?? this.orderList,
        orderItems: orderItems ?? this.orderItems,
        error: error ?? this.error,
        status: status ?? this.status);
  }
}
