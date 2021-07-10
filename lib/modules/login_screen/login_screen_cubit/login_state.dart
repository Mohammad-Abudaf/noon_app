part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class Initial extends LoginState {}

class GetDataSuccess extends LoginState{
  final GetDataSuccess loginData;
  GetDataSuccess(this.loginData);
}
class GetDataLoading extends LoginState{}
class GetDataError extends LoginState{
  final String error;
  GetDataError(this.error);
}

class PostDataSuccess extends LoginState{
  final LoginModel loginData;
  PostDataSuccess(this.loginData);
}
class PostDataLoading extends LoginState{}
class PostDataError extends LoginState{
  final String error;
  PostDataError(this.error);
}


