
import 'package:online_exam/api/model/response/forget_password_response.dart';
import 'package:online_exam/ui/common/widget_state.dart';

sealed class ForgetPasswordState {}

class ForgetPasswordLoadingState extends ForgetPasswordState {}

class ForgetPasswordLoadedState extends ForgetPasswordState {
  final ComponentState<String> forgetPasswordState;


  ForgetPasswordLoadedState(this.forgetPasswordState);
}

class ForgetPasswordErrorState extends ForgetPasswordState {
  final String exception;
  ForgetPasswordErrorState(this.exception);
}

class ForgetPasswordSuccessState extends ForgetPasswordState {
}

class NavigateToVerifyCodeEvent extends ForgetPasswordState {}

sealed class ForgetPasswordIntent {}

class ForgetPasswordInitialState extends ForgetPasswordIntent {}

class ForgetPasswordButtonClicked extends ForgetPasswordIntent {
  final String email;

  ForgetPasswordButtonClicked({required this.email});
}

class NavigateToVerifyCode extends ForgetPasswordIntent {}
