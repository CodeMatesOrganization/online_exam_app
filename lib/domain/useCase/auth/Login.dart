import 'package:injectable/injectable.dart';
import 'package:online_exam/api/model/request/login_request.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';

@injectable
class LoginUseCase {
  AuthRepo authRepo;
  LoginUseCase(this.authRepo);

  Future<Result<UserModel>> call(LoginRequest request) {
    return authRepo.login(request);
  }
}