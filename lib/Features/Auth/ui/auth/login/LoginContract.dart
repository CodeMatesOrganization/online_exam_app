import 'package:equatable/equatable.dart';
import 'package:online_exam/Features/Auth/domain/model/UserModel.dart';
import 'package:online_exam/Features/Auth/ui/common/widget_state.dart';


sealed class LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState with EquatableMixin {
  final ComponentState<UserModel?> loginState;

  LoginLoadedState(this.loginState);

  LoginLoadedState copyWith({
    ComponentState<UserModel?>? loginState,
  }) {
    return LoginLoadedState(
      loginState ?? this.loginState,
    );
  }

  @override
  List<Object?> get props => [loginState];
}

class LoginErrorState extends LoginState {
  final Exception exception;
  LoginErrorState(this.exception);
}

class LoginSuccessState extends LoginState {
  final UserModel user;
  LoginSuccessState(this.user);
}

class NavigateToForgotPasswordEvent extends LoginState {}

class NavigateToSignUpEvent extends LoginState {}


sealed class LoginIntent {}

class LoginInitialState extends LoginIntent {}

class LoginButtonClicked extends LoginIntent {
  final String email;
  final String password;

  LoginButtonClicked({
    required this.email,
    required this.password,
  });
}

class ForgetPasswordButtonClicked extends LoginIntent {}

class SignUpClicked extends LoginIntent {}
