import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'locale_cubit_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleInitial(locale: Locale("en"))) {
    try {
      var box = Hive.box("main");
      if (box != null) {
        String locale = box.get("locale");
        if (locale != null && locale != "") {
          if (locale == "hi") {
            emit(HindiLocale());
          } else {
            emit(EnglishLocale());
          }
        }
      }
    } catch (e) {
      print("Hive error" + e.toString());
    }
  }

  int getLocale() {
    return state.locale.languageCode == "hi" ? 0 : 1;
  }

  void changeLocale() {
    if (state is HindiLocale)
      emit(EnglishLocale());
    else
      emit(HindiLocale());
  }
}
