import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/repositories/cart_repository.dart';

class RemoveToCartUsecase implements UseCase<void, int> {
  final CartRepository repository;
  RemoveToCartUsecase(this.repository);
  @override
  Future<void> call(int id) async {
    return await repository.removeToCart(id);
  }
}
