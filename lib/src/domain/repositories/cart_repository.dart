import 'package:flutter_application_1/src/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<void> addToCart(int foodId, int quantity);
  Future<List<CartEntity>> getCart();
  Future<void> removeToCart(int foodId);
  Future<void> deleteFoodFromCart(int foodId);
  Future<void> updateCartQuantity(int foodId, int newQuantity);
}