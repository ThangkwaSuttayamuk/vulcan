import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/entities/order_entity.dart';
import 'package:flutter_application_1/src/domain/usecases/add_order_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Cubit<List<OrderEntity>> {
  final AddOrderUsecase addOrderUsecase;
  final GetOrderUsecase getOrderUsecase;

  OrderBloc({required this.addOrderUsecase, required this.getOrderUsecase})
      : super([]);

  void addToOrder(AddOrderUsecaseTypeParam params) async {
    await addOrderUsecase(params);
  }

  void loadCart() async {
    final foodCart = await getOrderUsecase(NoParams());
    emit(foodCart);
  }
}
