import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/api/model/request/sign_up_request.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';
import 'package:online_exam/ui/auth/signUp/SignUpContract.dart';
import 'package:online_exam/ui/common/widget_state.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpState> {
  final AuthRepo authRepo;

  SignUpLoadedState currentState = SignUpLoadedState(Idle());

  SignUpViewModel(this.authRepo) : super(SignUpLoadedState(Idle()));

  void doIntent(SignUpIntent intent) {
    if (intent is SignUpButtonClicked) {
      _handleSubmit(intent);
    } else if (intent is NavigateToLogin) {
      emit(NavigateToLoginEvent());
    } else if (intent is SignUpInitialState) {
      emit(SignUpLoadedState(Idle()));
    }
  }

  void _handleSubmit(SignUpButtonClicked intent) async {
    emit(SignUpLoadingState());

    final signUpRequest = SignUpRequest(
      firstName: intent.firstName,
      lastName: intent.lastName,
      rePassword: intent.confirmPassword,
      username: intent.userName,
      email: intent.email,
      password: intent.password,
      phone: intent.phone,
    );

    var result = await authRepo.signUp(signUpRequest);

    if (result is Success<UserModel>) {
      emit(SignUpSuccessState(result.data)); // Success مباشرة
    } else if (result is Failure<UserModel>) {
      emit(SignUpErrorState(result.exception)); // Error مباشرة
    }
  }
}