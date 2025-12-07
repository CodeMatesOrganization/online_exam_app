import 'package:online_exam/Features/Auth/api/model/request/login_request.dart';
import 'package:online_exam/Features/Auth/api/model/request/sign_up_request.dart';
import 'package:online_exam/Features/Auth/domain/result.dart';
import 'package:online_exam/Features/Auth/domain/model/AuthResponseModel.dart';


abstract class AuthRepo {
  Future<Result<AuthResponseModel>> login(LoginRequest request);
  Future<Result<AuthResponseModel>> signUp(SignUpRequest request);
  Future<Result<void>> forgetPassword(String email);
  Future<Result<void>> emailVerification(String resetCode);
  Future<Result<void>> resetPassword(String email, String newPassword);
}