import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/add_order_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_order_list_by_id.dart';
import 'package:flutter_application_1/src/domain/usecases/get_order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Cubit<dynamic> {
  final AddOrderUsecase addOrderUsecase;
  final GetOrderUsecase getOrderUsecase;
  final GetOrderListByIdUsecase getOrderListByIdUsecase;

  OrderBloc(
      {required this.addOrderUsecase,
      required this.getOrderUsecase,
      required this.getOrderListByIdUsecase})
      : super([]);

  void addToOrder(AddOrderUsecaseTypeParam params) async {
    await addOrderUsecase(params);
  }

  void loadOrder() async {
    final order = await getOrderUsecase(NoParams());
    emit(order);
  }

  void getOrderListById(int id) async {
    final orderList = await getOrderListByIdUsecase(id);
    emit(orderList);
  }
}
