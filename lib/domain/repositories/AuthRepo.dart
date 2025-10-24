import 'package:online_exam/api/model/request/login_request.dart';
import 'package:online_exam/api/model/request/sign_up_request.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/result.dart';

abstract class AuthRepo {
  Future<Result<UserModel>> login(LoginRequest request);
  Future<Result<UserModel>> signUp(SignUpRequest request);
}