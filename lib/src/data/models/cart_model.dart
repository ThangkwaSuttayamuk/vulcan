import 'package:flutter_application_1/src/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {

  CartModel({
    required super.id,
    required super.foodId,
    required super.name,
    required super.description,
    required super.image,
    required super.price,
    required super.quantity,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
        id: map['cartId'] ?? 0,
        foodId: map['foodId'] ?? 0,
        name: map['name'],
        description: map['description'],
        image: map['image'],
        price: map['price'],
        quantity: map['quantity']);
  }
}
