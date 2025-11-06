import 'package:online_exam/domain/model/UserModel.dart';

abstract class LoginIntent {}

class LoginButtonClicked extends LoginIntent {
  final String email;
  final String password;

  LoginButtonClicked(this.email, this.password);
}

class EmailChanged extends LoginIntent {
  final String email;
  EmailChanged(this.email);
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel user;
  LoginSuccess(this.user);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoginEmailError extends LoginState {
  final String message;
  LoginEmailError(this.message);
}
