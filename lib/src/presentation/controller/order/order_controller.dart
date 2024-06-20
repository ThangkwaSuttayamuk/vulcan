import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/add_order_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_order_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/order/order_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderNotifier extends StateNotifier<OrderState> {
  final AddOrderUsecase addOrderUsecase;
  final GetOrderUsecase getOrderUsecase;

  OrderNotifier(this.addOrderUsecase, this.getOrderUsecase)
      : super(OrderState());

  Future<void> addOrder(String address, String tel) async {
    final params = AddOrderUsecaseTypeParam(address, tel);
    await addOrderUsecase.call(params);
  }

  Future<void> orderlist() async {
    state = state.copyWith(status: OrderStatus.loading);
    await Future.delayed(Duration(seconds: 1));

    try {
      final orderList = await getOrderUsecase.call(NoParams());
      state = state.copyWith(
          orderList: orderList,
          status: orderList.isEmpty ? OrderStatus.empty : OrderStatus.success);
    } catch (e) {
      state = state.copyWith(error: e.toString(), status: OrderStatus.failure);
    }
  }
}
