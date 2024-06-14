import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/entities/cart_entity.dart';
import 'package:flutter_application_1/src/domain/usecases/add_to_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/remove_to_cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Cubit<List<CartEntity>> {
  final AddToCartUsecase addToCart;
  final GetCartUsecase getCart;
  final RemoveToCartUsecase removeToCart;

  CartBloc({
    required this.addToCart,
    required this.getCart,
    required this.removeToCart
  }) : super([]);

  void addCart(AddToCartUsecaseTypeParam params) async {
    await addToCart(params);
  }

  void loadCart() async {
    final foodCart = await getCart(NoParams());
    emit(foodCart);
  }

  void removeCart(int id) async{
    await removeToCart(id);
  }
}
