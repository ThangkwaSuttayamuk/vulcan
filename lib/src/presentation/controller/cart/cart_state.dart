import 'package:flutter_application_1/src/domain/entities/cart.dart';

class CartState {
  final List<Cart> cartList;
  final bool isLoading;
  final String? error;

  CartState({
    required this.cartList,
    this.isLoading = false,
    this.error,
  });

  CartState copyWith({List<Cart>? cartList, bool? isLoading, String? error}) {
    return CartState(
        cartList: cartList ?? this.cartList,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error);
  }
}
