part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class ChangeETHLoad extends SettingsState{}

class ChangeETHSucess extends SettingsState{}

class ChangeETHError extends SettingsState{}