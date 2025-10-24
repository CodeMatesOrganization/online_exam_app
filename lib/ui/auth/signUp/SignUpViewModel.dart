import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/api/model/request/sign_up_request.dart';
import 'package:online_exam/domain/result.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/useCase/auth/SignUp.dart';

@injectable
class SignUpViewModel extends ChangeNotifier {
  final SignupUseCase signUpUseCase;

  SignUpViewModel(this.signUpUseCase);

  bool isLoading = false;
  String? errorMessage;
  UserModel? user;

  Future<void> signUp({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    if (password != rePassword) {
      errorMessage = "Passwords do not match";
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final request = SignUpRequest(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );

    final result = await signUpUseCase.invoke(request);

    if (result is Success<UserModel>) {
      user = result.data;
    } else if (result is Failure<UserModel>) {
      errorMessage = result.exception.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
