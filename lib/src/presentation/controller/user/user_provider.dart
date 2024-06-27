import 'package:flutter_application_1/src/data/repositories/user_repository_impl.dart';
import 'package:flutter_application_1/src/dependency_injection.dart';
import 'package:flutter_application_1/src/domain/repositories/user_repository.dart';
import 'package:flutter_application_1/src/domain/usecases/get_user_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/user/user_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/user/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepositoryImpl(sl()));

final getUser =
    Provider((ref) => GetUserUsecase(ref.read(userRepositoryProvider)));

final userProvider =
    StateNotifierProvider.autoDispose<UserNotifier, UserState>((ref) {
  return UserNotifier(ref.read(getUser));
});
