import 'package:flutter_application_1/src/domain/entities/user_entity.dart';

enum UserStatus {
  initial,
  loading,
  notLogin,
  login,
  success,
  failure,
}

class UserState {
  final UserStatus status;
  final UserStatus loginStatus;
  final UserEntity? user;
  final String? error;

  const UserState({
    this.status = UserStatus.initial,
    this.loginStatus = UserStatus.loading,
    this.user,
    this.error,
  });

  UserState copyWith({
    UserStatus? status,
    UserStatus? loginStatus,
    UserEntity? user,
    String? error,
  }) {
    return UserState(
      status: status ?? this.status,
      loginStatus: loginStatus ?? this.loginStatus,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
