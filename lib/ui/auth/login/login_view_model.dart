import 'package:flutter/foundation.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/result.dart';
import 'package:online_exam/domain/useCase/auth/Login.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<Result<UserModel?>> login(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      final user = await _loginUseCase.call(email, password);

      _isLoading = false;
      notifyListeners();
      return user;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return null!;
    }
  }
}
