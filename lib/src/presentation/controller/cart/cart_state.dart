import 'package:flutter_application_1/src/domain/entities/cart_entity.dart';

enum CartStatus { initial, loading, success, failure, empty }

class CartState {
  final List<CartEntity>? cartList;
  final String? address;
  final String? tel;
  final CartStatus addressStatus;
  final CartStatus telStatus;
  final CartStatus status;
  final bool isLoading;
  final String? error;

  CartState({
    this.cartList,
    this.address,
    this.tel,
    this.addressStatus = CartStatus.empty,
    this.telStatus = CartStatus.empty,
    this.status = CartStatus.initial,
    this.isLoading = false,
    this.error,
  });

  CartState copyWith(
      {List<CartEntity>? cartList,
      String? address,
      String? tel,
      CartStatus? addressStatus,
      CartStatus? telStatus,
      bool? isLoading,
      String? error,
      CartStatus? status}) {
    return CartState(
        cartList: cartList ?? this.cartList,
        address: address ?? this.address,
        tel: tel ?? this.tel,
        addressStatus: addressStatus??this.addressStatus,
        telStatus: telStatus??this.telStatus,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        status: status ?? this.status);
  }
}
