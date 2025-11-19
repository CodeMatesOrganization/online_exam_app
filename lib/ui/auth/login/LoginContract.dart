import 'package:equatable/equatable.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/ui/common/widget_state.dart';

sealed class LoginState {}

class LoginLoadedState extends LoginState with EquatableMixin {
  final ComponentState<String> emailState;
  final ComponentState<String> passwordState;
  final bool rememberMe;
  final ComponentState<UserModel?> loginState;

  LoginLoadedState({
    required this.emailState,
    required this.passwordState,
    this.rememberMe = false,
    required this.loginState,
  });

  LoginLoadedState copyWith({
    ComponentState<String>? emailState,
    ComponentState<String>? passwordState,
    bool? rememberMe,
    ComponentState<UserModel?>? loginState,
  }) {
    return LoginLoadedState(
      emailState: emailState ?? this.emailState,
      passwordState: passwordState ?? this.passwordState,
      rememberMe: rememberMe ?? this.rememberMe,
      loginState: loginState ?? this.loginState,
    );
  }

  @override
  List<Object?> get props =>
      [emailState, passwordState, rememberMe, loginState];
}

class LoginErrorState extends LoginState {
  final Exception exception;
  LoginErrorState(this.exception);
}

class NavigateToHomeEvent extends LoginState with EquatableMixin {
  final UserModel user;
  NavigateToHomeEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class NavigateToForgotPasswordEvent extends LoginState {}

class NavigateToSignUpEvent extends LoginState {}


sealed class LoginIntent {}

class LoginInitialState extends LoginIntent {}

class EmailChanged extends LoginIntent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends LoginIntent {
  final String password;
  PasswordChanged(this.password);
}

class RememberMeToggled extends LoginIntent {
  final bool remember;
  RememberMeToggled(this.remember);
}

class LoginButtonClicked extends LoginIntent {}

class ForgotPasswordClicked extends LoginIntent {}

class SignUpClicked extends LoginIntent {}
