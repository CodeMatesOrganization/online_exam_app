import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/api/model/request/login_request.dart';
import 'package:online_exam/domain/result.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/useCase/auth/Login.dart';

@injectable
class LoginViewModel extends ChangeNotifier {
   LoginUseCase loginUseCase;

  LoginViewModel(this.loginUseCase);

  bool isLoading = false;
  String? errorMessage;
  UserModel? user;

   Future<void> login(String email, String password) async {
     isLoading = true;
     notifyListeners();

     final request = LoginRequest(email: email, password: password);

     final result = await loginUseCase(request);

     result is Success<UserModel>
         ? user = result.data
         : errorMessage = (result as Failure).exception.toString();

     isLoading = false;
     notifyListeners();
   }
}
