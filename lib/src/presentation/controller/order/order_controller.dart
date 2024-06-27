import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/add_order_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_order_list_by_id.dart';
import 'package:flutter_application_1/src/domain/usecases/get_order_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/order/order_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderNotifier extends StateNotifier<OrderState> {
  final AddOrderUsecase addOrderUsecase;
  final GetOrderUsecase getOrderUsecase;
  final GetOrderListByIdUsecase getOrderListByIdUsecase;

  OrderNotifier(
      this.addOrderUsecase, this.getOrderUsecase, this.getOrderListByIdUsecase)
      : super(OrderState());

  Future<void> addOrder(String address, String tel) async {
    final params = AddOrderUsecaseTypeParam(address, tel);
    await addOrderUsecase.call(params);
  }

  Future<void> orderlist() async {
    state = state.copyWith(status: OrderStatus.loading);
    await Future.delayed(const Duration(seconds: 1));

    try {
      final orderList = await getOrderUsecase.call(NoParams());
      state = state.copyWith(
          orderList: orderList,
          status: orderList.isEmpty ? OrderStatus.empty : OrderStatus.success);
    } catch (e) {
      state = state.copyWith(error: e.toString(), status: OrderStatus.failure);
    }
  }

  Future<void> getOrderListById(int id) async {
    // state = state.copyWith(status: OrderStatus.loading);
    // await Future.delayed(Duration(seconds: 1));

    try {
      final orderItems = await getOrderListByIdUsecase.call(id);
      state = state.copyWith(
        orderItems: orderItems,
        // status: orderItems.isEmpty ? OrderStatus.empty : OrderStatus.success
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), status: OrderStatus.failure);
    }
  }

  double getTotal() {
    double total = 0;

    for (var item in state.orderItems ?? []) {
      total = total + (item.quantity * item.price);
    }
    return total;
  }
}
