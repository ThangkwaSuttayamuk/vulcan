import 'package:flutter_application_1/src/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser(String username, String password);
}
