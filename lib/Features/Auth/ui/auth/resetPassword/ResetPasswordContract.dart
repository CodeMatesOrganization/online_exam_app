
import 'package:online_exam/Features/Auth/ui/common/widget_state.dart';

sealed class ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordLoadedState extends ResetPasswordState {
  final ComponentState<String> resetPasswordState;


  ResetPasswordLoadedState(this.resetPasswordState);
}

class ResetPasswordErrorState extends ResetPasswordState {
  final String exception;
  ResetPasswordErrorState(this.exception);
}

class ResetPasswordSuccessState extends ResetPasswordState {
  final String message;
  ResetPasswordSuccessState(this.message);

}

class NavigateToLoginEvent extends ResetPasswordState {}

sealed class ResetPasswordIntent {}

class ResetPasswordInitialState extends ResetPasswordIntent {}

class ResetPasswordButtonClicked extends ResetPasswordIntent {
  final String email;
  final String newPassword;

  ResetPasswordButtonClicked({required this.email , required this.newPassword});
}

class NavigateToLogin extends ResetPasswordIntent {}
