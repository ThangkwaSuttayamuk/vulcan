import 'package:flutter_application_1/src/domain/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  OrderItemModel({
    required super.orderId,
    required super.foodId,
    required super.quantity,
    required super.name,
    required super.image,
    required super.price,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
        orderId: map['orderItemId'],
        foodId: map['food_id'],
        quantity: map['quantity'],
        name: map['name'],
        image: map['image'],
        price: map['price']);
  }
}
