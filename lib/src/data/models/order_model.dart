import 'package:flutter_application_1/src/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  
  OrderModel(
      {super.id,
      required super.orderDate,
      required super.address,
      required super.tel});

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? 0,
      address: map['address'] ?? '',
      tel: map['tel'] ?? '',
      orderDate: map['order_date'],
    );
  }
}
