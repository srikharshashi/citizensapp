part of 'locale_cubit_cubit.dart';

@immutable
abstract class LocaleState {
  Locale locale;
  LocaleState({required this.locale});
}

class LocaleInitial extends LocaleState {
  LocaleInitial({required Locale locale}) : super(locale: locale);
}

class HindiLocale extends LocaleState {
  HindiLocale() : super(locale: Locale("hi"));
}

class EnglishLocale extends LocaleState {
  EnglishLocale() : super(locale: Locale("en"));
}