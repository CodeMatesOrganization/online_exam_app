import 'package:injectable/injectable.dart';
import 'package:online_exam/api/model/request/sign_up_request.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';

@injectable
class SignupUseCase {
  final AuthRepo authRepo;

  SignupUseCase(this.authRepo);

  Future<Result<UserModel>> invoke(SignUpRequest request) {
    return authRepo.signUp(request);
  }
}
