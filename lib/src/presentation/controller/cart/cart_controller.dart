import 'dart:async';

import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/add_to_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/delete_form_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/remove_to_cart_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<CartState> {
  final GetCartUsecase getCartUsecase;
  final AddToCartUsecase addToCartUsecase;
  final RemoveToCartUsecase removeToCartUsecase;
  final DeleteFormCartUsecase deleteFormCartUsecase;

  CartNotifier(this.getCartUsecase, this.addToCartUsecase,
      this.removeToCartUsecase, this.deleteFormCartUsecase)
      : super(CartState());

  Future<void> cartFoods() async {
    state = state.copyWith(status: CartStatus.loading);
    await Future.delayed(Duration(seconds: 1));

    state = state.copyWith(isLoading: true);
    try {
      final cartList = await getCartUsecase.call(NoParams());
      state = state.copyWith(
          cartList: cartList,
          isLoading: false,
          status: cartList.isEmpty ? CartStatus.empty : CartStatus.success);
    } catch (e) {
      state = state.copyWith(
          error: e.toString(), isLoading: false, status: CartStatus.failure);
    }
  }

  Future<void> addToCart(int id, int quantity) async {
    state.copyWith(isLoading: true);

    final params = AddToCartUsecaseTypeParam(id, quantity);

    try {
      await addToCartUsecase.call(params);
      final cartList = await getCartUsecase.call(NoParams());
      state = state.copyWith(
          cartList: cartList,
          isLoading: false,
          status: cartList.isEmpty ? CartStatus.empty : CartStatus.success);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> removeToCart(int id) async {
    state.copyWith(isLoading: true);

    try {
      await removeToCartUsecase.call(id);
      final cartList = await getCartUsecase.call(NoParams());
      state = state.copyWith(
          cartList: cartList,
          isLoading: false,
          status: cartList.isEmpty ? CartStatus.empty : CartStatus.success);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> deleteFormCart(int id) async {
    try {
      await deleteFormCartUsecase.call(id);
      final cartList = await getCartUsecase.call(NoParams());
      state = state.copyWith(
          cartList: cartList,
          isLoading: false,
          status: cartList.isEmpty ? CartStatus.empty : CartStatus.success);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> initData() async {
    state = state.copyWith(
        address: '',
        tel: '',
        telStatus: CartStatus.empty,
        addressStatus: CartStatus.empty);
  }

  Future<void> setAddress(String address) async {
    state = state.copyWith(
        address: address,
        addressStatus: address.isEmpty ? CartStatus.empty : CartStatus.success);
  }

  Future<void> setTel(String tel) async {
    state = state.copyWith(
        tel: tel,
        telStatus: tel.isEmpty ? CartStatus.empty : CartStatus.success);
  }

  int getTotalAmount() {
    print(state.cartList?.length);
    return state.cartList?.length ?? 0;
  }

  String getAddress() {
    return state.address ?? '';
  }

  String getTel() {
    return state.tel ?? '';
  }

  double getTotal() {
    double total = 0;

    for (var cart in state.cartList ?? []) {
      total = total + (cart.quantity * cart.price);
    }
    return total;
  }

  
}
