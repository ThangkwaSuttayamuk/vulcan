import 'package:flutter_application_1/src/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<int> addOrder(String address, String tel);
  Future<void> addOrderFromCart(String address, String tel);
  Future<List<OrderEntity>> getOrders();
}
