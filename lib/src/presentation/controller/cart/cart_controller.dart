import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/add_to_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/remove_to_cart_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<CartState> {
  final GetCartUsecase getCartUsecase;
  final AddToCartUsecase addToCartUsecase;
  final RemoveToCartUsecase removeToCartUsecase;

  CartNotifier(
      this.getCartUsecase, this.addToCartUsecase, this.removeToCartUsecase)
      : super(CartState(cartList: []));

  Future<void> cartFoods() async {
    state = state.copyWith(isLoading: true);
    try {
      final cartList = await getCartUsecase.call(NoParams());
      state = state.copyWith(cartList: cartList, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> addToCart(int id, int quantity) async {
    state.copyWith(isLoading: true);

    final params = AddToCartUsecaseTypeParam(id, quantity);

    try {
      await addToCartUsecase.call(params);
      final cartList = await getCartUsecase.call(NoParams());
      state = state.copyWith(cartList: cartList, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> removeToCart(int id) async {
    state.copyWith(isLoading: true);

    try {
      await removeToCartUsecase.call(id);
      final cartList = await getCartUsecase.call(NoParams());
      state = state.copyWith(cartList: cartList, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  int getTotalAmount() {
    return state.cartList.length;
  }

  double getTotal() {
    double total = 0;
    for (var cart in state.cartList) {
      total = total + (cart.quantity * cart.price);
    }
    return total;
  }
}
