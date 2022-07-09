part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoad extends LocationState {}

class LocationGot extends LocationState {
  Position position;
  LocationGot({required this.position});
}

class LocationError extends LocationState {
  String message;
  LocationError({required this.message});
}
