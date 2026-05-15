import 'package:equatable/equatable.dart';
import 'package:online_exam/Features/Auth/domain/model/UserModel.dart';
import 'package:online_exam/Features/Auth/ui/common/widget_state.dart';


sealed class SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpLoadedState extends SignUpState with EquatableMixin {
  final ComponentState<UserModel?> signUpState;

  SignUpLoadedState(this.signUpState);

  SignUpLoadedState copyWith({
    ComponentState<UserModel?>? signUpState,
  }) {
    return SignUpLoadedState(
      signUpState ?? this.signUpState,
    );
  }

  @override
  List<Object?> get props => [signUpState];
}
class SignUpErrorState extends SignUpState {
  final Exception exception;
  SignUpErrorState(this.exception);
}
class SignUpSuccessState extends SignUpState{
  final UserModel user;
  SignUpSuccessState(this.user);
}


class NavigateToLoginEvent extends SignUpState {}


sealed class SignUpIntent {}

class SignUpInitialState extends SignUpIntent {}

class SignUpButtonClicked extends SignUpIntent {
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;

  SignUpButtonClicked({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
  });
}

class NavigateToLogin extends SignUpIntent {

}




