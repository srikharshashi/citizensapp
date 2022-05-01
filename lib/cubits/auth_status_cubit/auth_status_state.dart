part of 'auth_status_cubit.dart';

@immutable
abstract class AuthstatusState {}

class AuthstatusInitial extends AuthstatusState {}

class LoggedIn extends AuthstatusState {
  String username;
  LoggedIn({required this.username});
}

class LoggedOut extends AuthstatusState {}
