part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}


class LoginLoad extends LoginState {}

class LoginSuccess extends LoginState {
  String name;
  LoginSuccess({required this.name});
}

class PasswordErrorState extends LoginState {}

class UserNotFound extends LoginState {}

class LoginError extends LoginState {}
