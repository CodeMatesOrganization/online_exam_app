import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Auth/api/model/request/sign_up_request.dart';
import 'package:online_exam/Features/Auth/domain/model/AuthResponseModel.dart';
import 'package:online_exam/Features/Auth/domain/repositories/AuthRepo.dart';
import 'package:online_exam/Features/Auth/domain/result.dart';

@injectable
class SignupUseCase {
  final AuthRepo authRepo;

  SignupUseCase(this.authRepo);

  Future<Result<AuthResponseModel>> invoke(SignUpRequest request) {
    return authRepo.signUp(request);
  }
}
