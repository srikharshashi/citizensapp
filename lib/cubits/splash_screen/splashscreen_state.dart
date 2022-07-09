part of 'splashscreen_cubit.dart';

@immutable
abstract class SplashscreenState {}

class SplashscreenInitial extends SplashscreenState {}

class ConnectivityError extends SplashscreenState {}

class ShowButtons extends SplashscreenState {}

class ToHome extends SplashscreenState {
  String name;
  ToHome({required this.name});
}

class SessionExpired extends SplashscreenState {}
