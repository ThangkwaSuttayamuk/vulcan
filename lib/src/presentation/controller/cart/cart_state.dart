import 'package:flutter_application_1/src/domain/entities/cart_entity.dart';

enum CartStatus { initial, loading, success, failure, empty }

class CartState {
  final List<CartEntity>? cartList;
  final CartStatus status;
  final bool isLoading;
  final String? error;

  CartState({
     this.cartList,
    this.status = CartStatus.initial,
    this.isLoading = false,
    this.error,
  });

  CartState copyWith(
      {List<CartEntity>? cartList,
      bool? isLoading,
      String? error,
      CartStatus? status}) {
    return CartState(
        cartList: cartList ?? this.cartList,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        status: status ?? this.status);
  }
}
