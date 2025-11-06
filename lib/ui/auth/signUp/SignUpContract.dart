import 'package:online_exam/domain/model/UserModel.dart';

abstract class SignUpIntent {}

class SignUpButtonClicked extends SignUpIntent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  SignUpButtonClicked({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}

class SignUpEmailChanged extends SignUpIntent {
  final String email;
  SignUpEmailChanged(this.email);
}

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final UserModel user;
  SignUpSuccess(this.user);
}

class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}

class SignUpEmailError extends SignUpState {
  final String message;
  SignUpEmailError(this.message);
}
