import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Auth/api/model/request/login_request.dart';
import 'package:online_exam/Features/Auth/domain/model/AuthResponseModel.dart';
import 'package:online_exam/Features/Auth/domain/repositories/AuthRepo.dart';
import 'package:online_exam/Features/Auth/domain/result.dart';

@injectable
class LoginUseCase {
  AuthRepo authRepo;
  LoginUseCase(this.authRepo);

  Future<Result<AuthResponseModel>> call(LoginRequest request) {
    return authRepo.login(request);
  }
}