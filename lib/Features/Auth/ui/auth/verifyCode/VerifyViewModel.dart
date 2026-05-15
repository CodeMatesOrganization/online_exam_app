import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Auth/domain/repositories/AuthRepo.dart';
import 'package:online_exam/Features/Auth/domain/result.dart';
@injectable
class VerifyViewModel extends Cubit<VerifyState> {
  final AuthRepo authRepo;

  VerifyViewModel(this.authRepo) : super(VerifyInitialState());

  Future<bool> verifyCode(String code) async {
    emit(VerifyLoadingState());
    try {
      final result = await authRepo.emailVerification(code); // Result<void>

      if (result is Success<void>) {
        emit(VerifySuccessState("Code is valid"));
        return true;
      } else if (result is Failure<void>) {
        emit(VerifyErrorState("Invalid code, please try again"));
        return false;
      } else {
        emit(VerifyErrorState("Something went wrong"));
        return false;
      }
    } catch (e) {
      emit(VerifyErrorState("Something went wrong"));
      return false;
    }
  }

}

sealed class VerifyState {}

class VerifyInitialState extends VerifyState {}

class VerifyLoadingState extends VerifyState {}

class VerifyErrorState extends VerifyState {
  final String errorMessage;
  VerifyErrorState(this.errorMessage);
}

class VerifySuccessState extends VerifyState {
  final String message;
  VerifySuccessState(this.message);
}
