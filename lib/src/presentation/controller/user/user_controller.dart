import 'package:flutter_application_1/src/domain/entities/user_entity.dart';
import 'package:flutter_application_1/src/domain/usecases/get_user_usecase.dart';
import 'package:flutter_application_1/src/presentation/controller/user/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends StateNotifier<UserState> {
  final GetUserUsecase getUserUsecase;

  UserNotifier(this.getUserUsecase) : super(const UserState());

  late SharedPreferences loginData;
  late bool newUser;

  void getUser(String username, String password) async {
    state = state.copyWith(status: UserStatus.loading);
    try {
      final params = GetUserUsecaseTypeParam(username, password);
      UserEntity response = await getUserUsecase.call(params);
      state = state.copyWith(user: response, status: UserStatus.success);
    } catch (e) {
      state = state.copyWith(error: e.toString(), status: UserStatus.failure);
    }
  }

  void logOut() {
    state = state.copyWith(user: null, status: UserStatus.initial);
  }

  void statusInit() {
    state = state.copyWith(status: UserStatus.initial);
  }

  void checkLogin() async {
    state = state.copyWith(loginStatus: UserStatus.loading);
    await Future.delayed(const Duration(seconds: 20));

    try {
      loginData = await SharedPreferences.getInstance();
      newUser = (loginData.getBool('login') ?? true);
      if (newUser) {
        state = state.copyWith(loginStatus: UserStatus.initial);
      } else {
        state = state.copyWith(loginStatus: UserStatus.success);
      }
    } catch (e) {
      state =
          state.copyWith(error: e.toString(), loginStatus: UserStatus.failure);
    }
  }
}
