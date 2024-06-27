import 'package:flutter_application_1/src/data/repositories/order_repository_impl.dart';
import 'package:flutter_application_1/src/domain/repositories/order_repository.dart';
import 'package:flutter_application_1/src/domain/usecases/add_order_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_order_list_by_id.dart';
import 'package:flutter_application_1/src/domain/usecases/get_order_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/order/order_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/order/order_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dependency_injection.dart';

final orderRepsitryProvider =
    Provider<OrderRepository>((ref) => OrderRepositoryImpl(sl()));

final addOrder =
    Provider((ref) => AddOrderUsecase(ref.read(orderRepsitryProvider)));

final getOrder =
    Provider((ref) => GetOrderUsecase(ref.read(orderRepsitryProvider)));

final getOrderById =
    Provider((ref) => GetOrderListByIdUsecase(ref.read(orderRepsitryProvider)));

final orderProvider =
    StateNotifierProvider.autoDispose<OrderNotifier, OrderState>((ref) {
  return OrderNotifier(
      ref.read(addOrder), ref.read(getOrder), ref.read(getOrderById));
});
