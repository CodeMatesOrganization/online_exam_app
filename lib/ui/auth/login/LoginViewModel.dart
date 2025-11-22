import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/api/model/request/login_request.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/result.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/ui/auth/login/LoginContract.dart';
import 'package:online_exam/ui/common/widget_state.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginViewModel(this.authRepo) : super(LoginLoadedState(Idle()));

  void doIntent(LoginIntent intent) {
    if (intent is LoginButtonClicked) {
      _handleLogin(intent);
    } else if (intent is ForgetPasswordButtonClicked) {
      emit(NavigateToForgotPasswordEvent());
    } else if (intent is SignUpClicked) {
      emit(NavigateToSignUpEvent());
    } else if (intent is LoginInitialState) {
      emit(LoginLoadedState(Idle()));
    }
  }

  void _handleLogin(LoginButtonClicked intent) async {
    emit(LoginLoadingState());

    final request = LoginRequest(
      email: intent.email,
      password: intent.password,
    );

    var result = await authRepo.login(request);

    if (result is Success<UserModel>) {
      emit(LoginSuccessState(result.data));
    } else if (result is Failure<UserModel>) {
      emit(LoginErrorState(result.exception));
    }
  }
}
