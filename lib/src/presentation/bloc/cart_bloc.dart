import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/entities/cart_entity.dart';
import 'package:flutter_application_1/src/domain/usecases/add_to_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/delete_form_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/remove_to_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Cubit<List<CartEntity>> {
  final AddToCartUsecase addToCart;
  final GetCartUsecase getCart;
  final RemoveToCartUsecase removeToCart;
  final DeleteFormCartUsecase deleteFormCartUsecase;
  final UpdateCartQuantityUsecase updateCartQuantityUsecase;

  CartBloc(
      {required this.addToCart,
      required this.getCart,
      required this.removeToCart,
      required this.deleteFormCartUsecase,
      required this.updateCartQuantityUsecase})
      : super([]);

  void addCart(AddToCartUsecaseTypeParam params) async {
    await addToCart(params);
  }

  void loadCart() async {
    final foodCart = await getCart(NoParams());
    emit(foodCart);
  }

  void removeCart(int id) async {
    await removeToCart(id);
  }

  void deleteFormCart(int id) async {
    await deleteFormCartUsecase(id);
  }

  void updateCartQuantity(UpdateCartQuantityUsecaseTypeParam params) async {
    await updateCartQuantityUsecase(params);
  }
}
