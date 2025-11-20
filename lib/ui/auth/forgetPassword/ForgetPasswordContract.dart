
import 'package:online_exam/ui/common/widget_state.dart';

sealed class ForgetPasswordState {}

class ForgetPasswordLoadingState extends ForgetPasswordState {}

class ForgetPasswordLoadedState extends ForgetPasswordState {
  final ComponentState<String> forgetPasswordState;


  ForgetPasswordLoadedState(this.forgetPasswordState);
}

class ForgetPasswordErrorState extends ForgetPasswordState {
  final Exception exception;
  ForgetPasswordErrorState(this.exception);
}

class ForgetPasswordSuccessState extends ForgetPasswordState {
  final String message;
  ForgetPasswordSuccessState(this.message);
}

class NavigateToResetPasswordEvent extends ForgetPasswordState {}

sealed class ForgetPasswordIntent {}

class ForgetPasswordInitialState extends ForgetPasswordIntent {}

class ForgetPasswordButtonClicked extends ForgetPasswordIntent {
  final String email;

  ForgetPasswordButtonClicked({required this.email});
}

class NavigateToResetPassword extends ForgetPasswordIntent {}
