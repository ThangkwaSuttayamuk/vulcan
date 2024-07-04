import 'package:flutter_application_1/src/data/repositories/cart_repository_impl.dart';
import 'package:flutter_application_1/src/dependency_injection.dart';
import 'package:flutter_application_1/src/domain/repositories/cart_repository.dart';
import 'package:flutter_application_1/src/domain/usecases/add_to_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/delete_form_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/remove_to_cart_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartRepsitryProvider =
    Provider<CartRepository>((ref) => CartRepositoryImpl(sl()));

final getCart =
    Provider((ref) => GetCartUsecase(ref.read(cartRepsitryProvider)));

final addToCart =
    Provider((ref) => AddToCartUsecase(ref.read(cartRepsitryProvider)));

final removeToCart =
    Provider((ref) => RemoveToCartUsecase(ref.read(cartRepsitryProvider)));

final deleteFormCart =
    Provider((ref) => DeleteFormCartUsecase(ref.read(cartRepsitryProvider)));

final cartProvider =
    StateNotifierProvider.autoDispose<CartNotifier, CartState>((ref) {
  return CartNotifier(
      ref.read(getCart), ref.read(addToCart), ref.read(removeToCart),ref.read(deleteFormCart));
});
