import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/entities/user_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/user_repository.dart';

class GetUserUsecase implements UseCase<UserEntity, GetUserUsecaseTypeParam> {
  final UserRepository repository;
  GetUserUsecase(this.repository);

  @override
  Future<UserEntity> call(GetUserUsecaseTypeParam params) async {
    return await repository.getUser(params.username, params.password);
  }
}

class GetUserUsecaseTypeParam {
  final String username;
  final String password;
  const GetUserUsecaseTypeParam(this.username, this.password);
}
