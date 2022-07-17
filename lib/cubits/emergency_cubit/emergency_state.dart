part of 'emergency_cubit.dart';

@immutable
abstract class EmergencyState {}

class EmergencyInitial extends EmergencyState {}


class EmergencyLoad extends EmergencyState{}

class EmergencySucess extends EmergencyState{}

class EmergencyError extends EmergencyState{}