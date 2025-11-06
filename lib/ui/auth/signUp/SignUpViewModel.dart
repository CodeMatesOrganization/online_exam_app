import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/api/model/request/sign_up_request.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';
import 'package:online_exam/ui/auth/signUp/SignUpContract.dart';

@injectable
class SignUpViewModel extends Bloc<SignUpIntent, SignUpState> {
  final AuthRepo authRepo;

  SignUpViewModel(this.authRepo) : super(SignUpInitial()) {
    on<SignUpButtonClicked>(_onSignUpClicked);
    on<SignUpEmailChanged>(_onEmailChanged);
  }

  Future<void> _onSignUpClicked(
      SignUpButtonClicked event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading());

    final result = await authRepo.signUp(SignUpRequest(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
    ));

    if (result is Success<UserModel>) {
      emit(SignUpSuccess(result.data));
    } else if (result is Failure<UserModel>) {
      emit(SignUpError(result.exception.toString()));
    }
  }

  void _onEmailChanged(
      SignUpEmailChanged event,
      Emitter<SignUpState> emit,
      ) {
    final email = event.email.trim();
    final isValid =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

    if (!isValid) {
      emit(SignUpEmailError("Please enter a valid email address"));
    } else {
      emit(SignUpInitial());
    }
  }
}
