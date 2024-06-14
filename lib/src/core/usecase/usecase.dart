abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class UseCaseParams<Type, Params, Params2> {
  Future<Type> call(Params params,Params2 params2);
}

class NoParams {
  List<Object> get props => [];
}
