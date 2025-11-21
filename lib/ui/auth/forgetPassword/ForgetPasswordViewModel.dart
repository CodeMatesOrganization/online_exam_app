 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/api/model/response/forget_password_response.dart';
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
     }else if (intent is NavigateToVerifyCode) {
      emit(NavigateToVerifyCodeEvent());
    } else if (intent is ForgetPasswordInitialState) {
        emit(ForgetPasswordLoadedState(Idle()));
      }
    }

  _onForgetPasswordClicked(ForgetPasswordButtonClicked intent) async {
    emit(ForgetPasswordLoadingState());

    Result result = await authRepo.forgetPassword(intent.email);

    if (result is Success) {
      emit(ForgetPasswordSuccessState());
    } else if (result is Failure) {
      emit(ForgetPasswordErrorState("Email not found"));
    }
  }


 }