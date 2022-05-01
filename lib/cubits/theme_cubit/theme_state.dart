part of 'theme_cubit.dart';

abstract class ThemeState {
  final ThemeData themeData;
  ThemeState({required this.themeData});
}

class LightTheme extends ThemeState {
  LightTheme() : super(themeData: AppTheme.lightTheme);
}

class DarkTheme extends ThemeState {
  DarkTheme() : super(themeData: AppTheme.darkTheme);
}
