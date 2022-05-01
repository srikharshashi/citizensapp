import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:citizensapp/services/exceptions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:citizensapp/services/auth_service.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  AuthService authService;
  final box = Hive.box("main");
  LoginCubit({required this.authService}) : super(LoginInitial());

  void login(String username, String password) async {
    emit(LoginLoad());

    try {
      Map<String, dynamic> response =
          await authService.login(username, password);
      if (response["login"]) {
        box.put("jwt", response["token"]);
        box.put("user", username);
      }
      emit(LoginSuccess(name: username));
    } on PasswordError {
      emit(PasswordErrorState());
    } on UserNotFoundError {
      emit(UserNotFound());
    } on APIKeyError {
      emit(LoginError());
    } on InternetError {
      emit(LoginError());
    }
  }

  void reload() {
    emit(LoginInitial());
  }

}
