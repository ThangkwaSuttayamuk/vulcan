import 'package:flutter_application_1/src/domain/entities/cart_entity.dart';

enum HomeStatus { initial, loading, success, failure, empty }

class CartState {
  final List<CartEntity> cartList;
  final HomeStatus? status;
  final bool isLoading;
  final String? error;

  CartState({
    required this.cartList,
    this.status,
    this.isLoading = false,
    this.error,
  });

  CartState copyWith(
      {List<CartEntity>? cartList,
      bool? isLoading,
      String? error,
      HomeStatus? status}) {
    return CartState(
        cartList: cartList ?? this.cartList,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        status: status ?? this.status);
  }
}
