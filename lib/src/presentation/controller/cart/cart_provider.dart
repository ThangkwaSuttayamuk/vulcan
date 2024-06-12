import 'package:flutter_application_1/src/presentation/controller/cart/cart_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider =
    StateNotifierProvider.autoDispose<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
