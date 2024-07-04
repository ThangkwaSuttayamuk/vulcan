import 'package:flutter_application_1/src/domain/entities/user_entity.dart';
import 'package:flutter_application_1/src/domain/usecases/get_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Cubit<UserEntity> {
  final GetUserUsecase getUser;

  UserBloc({
    required this.getUser,
  }) : super([] as UserEntity);

}
