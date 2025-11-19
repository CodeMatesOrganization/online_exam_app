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

  LoginLoadedState currentState = LoginLoadedState(
    emailState: Idle(),
    passwordState: Idle(),
    rememberMe: false,
    loginState: Idle(),
  );

  LoginViewModel(this.authRepo)
      : super(LoginLoadedState(
    emailState: Idle(),
    passwordState: Idle(),
    rememberMe: false,
    loginState: Idle(),
  ));

  void doIntent(LoginIntent intent) {
    switch (intent) {
      case LoginInitialState():
        emit(LoginLoadedState(
          emailState: Idle(),
          passwordState: Idle(),
          rememberMe: false,
          loginState: Idle(),
        ));
        break;

      case EmailChanged():
        final e = intent as EmailChanged;
        _sendState(currentState.copyWith(
          emailState: Loaded(e.email),
        ));
        break;

      case PasswordChanged():
        final p = intent as PasswordChanged;
        _sendState(currentState.copyWith(
          passwordState: Loaded(p.password),
        ));
        break;

      case RememberMeToggled():
        final r = intent as RememberMeToggled;
        _sendState(currentState.copyWith(
          rememberMe: r.remember,
        ));
        break;

      case LoginButtonClicked():
        _handleLogin();
        break;

      case ForgotPasswordClicked():
        emit(NavigateToForgotPasswordEvent());
        break;

      case SignUpClicked():
        emit(NavigateToSignUpEvent());
        break;
    }
  }

  void _handleLogin() async {
    final email = (currentState.emailState as Loaded<String>).data ?? "";
    final password = (currentState.passwordState as Loaded<String>).data ?? "";

    _sendState(currentState.copyWith(loginState: Loading()));

    final result = await authRepo.login(
      LoginRequest(email: email, password: password),
    );

    switch (result) {
      case Success<UserModel>():
        emit(NavigateToHomeEvent(result.data));
        break;

      case Failure<UserModel>():
        _sendState(currentState.copyWith(
          loginState: ComponentError(result.exception),
        ));
        break;
    }
  }

  void _sendState(LoginLoadedState state) {
    currentState = state;
    emit(state);
  }
}
