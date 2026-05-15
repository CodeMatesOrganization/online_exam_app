import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Auth/api/model/request/sign_up_request.dart';
import 'package:online_exam/Features/Auth/domain/model/AuthResponseModel.dart';
import 'package:online_exam/Features/Auth/domain/repositories/AuthRepo.dart';
import 'package:online_exam/Features/Auth/domain/result.dart';
import 'package:online_exam/Features/Auth/ui/auth/signUp/SignUpContract.dart';
import 'package:online_exam/Features/Auth/ui/common/widget_state.dart';

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

    if (result is Success<AuthResponseModel>) {
      emit(SignUpSuccessState(result.data.user!));
    } else if (result is Failure<AuthResponseModel>) {
      emit(SignUpErrorState(result.exception));
    }
  }
}