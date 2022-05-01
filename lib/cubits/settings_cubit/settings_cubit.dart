import 'package:bloc/bloc.dart';
import 'package:citizensapp/services/auth_service.dart';
import 'package:meta/meta.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  AuthService authService;
  SettingsCubit({required this.authService}) : super(SettingsInitial());

  void changeETH(String newETH) async {
    final box = Hive.box("main");
    print("in here");
    emit(ChangeETHLoad());
    try {
      final response = await authService.changeETH(box.get("jwt"), newETH);
      print(response);
      emit(ChangeETHSucess());
    } catch (e) {
      emit(ChangeETHError());
      print(e);
    }
  }

  void reload() {
    emit(SettingsInitial());
  }
}
