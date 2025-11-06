import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/api/model/request/login_request.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';
import 'package:online_exam/ui/auth/login/LoginContract.dart';

@injectable
class LoginViewModel extends Bloc<LoginIntent, LoginState> {
  final AuthRepo authRepo;

  LoginViewModel(this.authRepo) : super(LoginInitial()) {
    on<LoginButtonClicked>(_onLoginClicked);
    on<EmailChanged>(_onEmailChanged);
  }

  Future<void> _onLoginClicked(
      LoginButtonClicked event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());

    final result = await authRepo.login(LoginRequest(
      email: event.email,
      password: event.password,
    ));

    if (result is Success<UserModel>) {
      emit(LoginSuccess(result.data));
    } else if (result is Failure<UserModel>) {
      emit(LoginError(result.exception.toString()));
    }
  }

  void _onEmailChanged(
      EmailChanged event,
      Emitter<LoginState> emit,
      ) {
    final email = event.email.trim();
    final isValid =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

    if (!isValid) {
      emit(LoginEmailError("Please enter a valid email address"));
    } else {
      emit(LoginInitial());
    }
  }
}
