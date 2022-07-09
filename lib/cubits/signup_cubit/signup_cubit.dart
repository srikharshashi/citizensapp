import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:citizenapp2/services/auth_service.dart';
import 'package:citizenapp2/services/exceptions.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  AuthService authService;

  SignupCubit({required this.authService}) : super(SignupInitial());

  void signup(String username, String password, String ETH) async {
    emit(SignUpLoad());
    try {
      var response = await authService.signup(username, password, ETH);
      if (!response["user_exists"]) {
        emit(SignUpSucess());
      }
    } on UserAlreadyExistsError {
      emit(UserExists());
    } on APIKeyError {
      emit(SignUpFail());
    }
  }

  void reload() {
    emit(SignupInitial());
  }
}
