import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import 'package:online_exam/api/model/request/sign_up_request.dart';
import 'package:online_exam/domain/exceptions/custome_exception.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';
import 'package:online_exam/ui/auth/signUp/SignUpContract.dart';
import 'package:online_exam/ui/common/widget_state.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpState> {
  final AuthRepo authRepo;

  SignUpLoadedState currentState = SignUpLoadedState(
      Idle()
  );

  SignUpViewModel(this.authRepo) : super( SignUpLoadedState(
      Idle()
  )) ;


  void doIntent(SignUpIntent intent) {
    switch (intent) {

      case SignUpButtonClicked():
        _handleSubmit(intent);
      case NavigateToLogin():
        emit(NavigateToLoginEvent());
        case SignUpInitialState():
        emit(SignUpLoadedState(
            Idle()
        ));

    }
}

  void _handleSubmit(SignUpButtonClicked intent) async {
    emit(SignUpLoadingState());
      var result = await authRepo.signUp(
        SignUpRequest(
          firstName: intent.firstName,
          lastName: intent.lastName,
          rePassword: intent.confirmPassword,
          username: intent.userName,
          email: intent.email,
          password: intent.password,
          phone: intent.phone,
        ),
      );
      _sendState(currentState.copyWith(
          signUpState: Loading()));
      switch (result) {
        case Success<UserModel>():
          {
            _sendState(
              currentState.copyWith(signUpState: Loaded(result.data)),
            );
            break;
          }
        case Failure<UserModel>():
          {
            _sendState(
              currentState.copyWith(signUpState: ComponentError(result.exception)),
            );
            break;

      }
    }

  }


  void _sendState(SignUpLoadedState state) {
    currentState = state;
    emit(state);
  }
}



