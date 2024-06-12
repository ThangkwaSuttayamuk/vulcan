import 'package:flutter_application_1/src/presentation/controller/cart/cart_state.dart';
import 'package:flutter_application_1/utils/database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState(cartList: []));
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<void> fetchFoods() async {
    state = state.copyWith(isLoading: true);
    try {
      final cartList = await dbHelper.getCart();
      state = state.copyWith(cartList: cartList, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
