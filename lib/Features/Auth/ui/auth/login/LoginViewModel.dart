import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Auth/api/model/request/login_request.dart';
import 'package:online_exam/Features/Auth/domain/model/AuthResponseModel.dart';
import 'package:online_exam/Features/Auth/domain/result.dart';
import 'package:online_exam/Features/Auth/domain/repositories/AuthRepo.dart';
import 'package:online_exam/Features/Auth/ui/auth/login/LoginContract.dart';
import 'package:online_exam/Features/Auth/ui/common/widget_state.dart';
import 'package:online_exam/core/SharedPref.dart';
import 'package:online_exam/di.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginViewModel(this.authRepo) : super(LoginLoadedState(Idle()));

  void doIntent(LoginIntent intent) {
    if (intent is LoginButtonClicked) {
      _handleLogin(intent);
    } else if (intent is ForgetPasswordButtonClicked) {
      emit(NavigateToForgotPasswordEvent());
    } else if (intent is SignUpClicked) {
      emit(NavigateToSignUpEvent());
    } else if (intent is LoginInitialState) {
      emit(LoginLoadedState(Idle()));
    }
  }

  void _handleLogin(LoginButtonClicked intent) async {
    emit(LoginLoadingState());

    final request = LoginRequest(
      email: intent.email,
      password: intent.password,
    );

    var result = await authRepo.login(request);

    if (result is Success<AuthResponseModel>) {
      await getIt<SharedPreferencesHelper>()
          .saveToken(result.data.token);
      emit(LoginSuccessState(result.data.user!));
    } else if (result is Failure<AuthResponseModel>) {
      emit(LoginErrorState(result.exception));
    }
  }
}
