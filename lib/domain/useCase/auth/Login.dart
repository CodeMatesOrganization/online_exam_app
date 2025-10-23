import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';

@injectable
class LoginUseCase {
  AuthRepo authRepo;
  LoginUseCase(this.authRepo);

  Future<Result<UserModel>> call(String email , String password) {
    return authRepo.login(email, password);
  }
}