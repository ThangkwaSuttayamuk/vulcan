import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/entities/cart_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/cart_repository.dart';

class GetCartUsecase implements UseCase<List<CartEntity>, NoParams> {
  final CartRepository repository;

  GetCartUsecase(this.repository);
  
  @override
  Future<List<CartEntity>> call(NoParams noParams) async {
    return await repository.getCart();
  }
}
