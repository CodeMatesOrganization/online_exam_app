 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';
import 'package:online_exam/ui/auth/resetPassword/ResetPasswordContract.dart';
import 'package:online_exam/ui/common/widget_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ResetPasswordViewModel extends Cubit<ResetPasswordState> {

  final AuthRepo authRepo;

  ResetPasswordLoadedState currentState = ResetPasswordLoadedState(Idle());


  ResetPasswordViewModel(this.authRepo) : super(ResetPasswordLoadedState(Idle()));

    void doIntent(ResetPasswordIntent intent) {
      if (intent is ResetPasswordButtonClicked) {
        _onResetPasswordClicked(intent);
     }else if (intent is NavigateToLogin) {
      emit(NavigateToLoginEvent());
    } else if (intent is ResetPasswordInitialState) {
        emit(ResetPasswordLoadedState(Idle()));
      }
    }

  _onResetPasswordClicked(ResetPasswordButtonClicked intent) async {
    print("NEW PASSWORD = ${intent.newPassword}");

      emit(ResetPasswordLoadingState());

    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('reset_email');

    if (savedEmail == null) {
      emit(ResetPasswordErrorState("No saved email found"));
      return;
    }

    var result = await authRepo.resetPassword(intent.email , intent.newPassword);

    if (result is Success) {
      emit(ResetPasswordSuccessState("Password changed successfully"));
    } else if (result is Failure) {
      emit(ResetPasswordErrorState(result.exception.toString()));
    }
  }
}