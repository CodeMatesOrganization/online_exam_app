import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/result.dart';
import 'package:online_exam/domain/useCase/auth/Login.dart';

@injectable
class LoginViewModel extends ChangeNotifier{
  LoginUseCase loginUseCase;
  LoginViewModel(this.loginUseCase);

  UserModel? user;

  Future<void> login(String email, String password) async {
    var result = await loginUseCase.call(email, password);
    switch (result) {
      case Success<UserModel>():
        {
          user = result.data;
        }
      case Failure<UserModel>():
        {}
    }
  }
}
