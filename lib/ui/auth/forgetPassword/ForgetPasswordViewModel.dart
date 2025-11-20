 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';
import 'package:online_exam/ui/auth/forgetPassword/ForgetPasswordContract.dart';
import 'package:online_exam/ui/common/widget_state.dart';

 @injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {

  final AuthRepo authRepo;

  ForgetPasswordLoadedState currentState = ForgetPasswordLoadedState(Idle());


  ForgetPasswordViewModel(this.authRepo) : super(ForgetPasswordLoadedState(Idle()));

    void doIntent(ForgetPasswordIntent intent) {
      if (intent is ForgetPasswordButtonClicked) {
        _onForgetPasswordClicked(intent);
     }else if (intent is NavigateToResetPassword) {
      emit(NavigateToResetPasswordEvent());
    } else if (intent is ForgetPasswordInitialState) {
        emit(ForgetPasswordLoadedState(Idle()));
      }
    }

  _onForgetPasswordClicked(ForgetPasswordButtonClicked intent) async {
    emit(ForgetPasswordLoadingState());

    var result = await authRepo.forgetPassword(intent.email);

    if (result is Success<String>) {
      emit(ForgetPasswordSuccessState(result.data));
    } else if (result is Failure<String>) {
      emit(ForgetPasswordErrorState(result.exception));
    }
  }
}