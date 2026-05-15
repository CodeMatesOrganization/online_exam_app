import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Auth/domain/repositories/AuthRepo.dart';
import 'package:online_exam/Features/Auth/domain/result.dart';

@injectable
class ForgotPasswordUseCase {
  final AuthRepo authRepo;

  ForgotPasswordUseCase(this.authRepo);

  Future<Result<void>> call(String email) {
    return authRepo.forgetPassword(email);
  }
}
