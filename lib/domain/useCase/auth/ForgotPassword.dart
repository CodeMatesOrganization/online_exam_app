import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';

@injectable
class ForgotPasswordUseCase {
  final AuthRepo authRepo;

  ForgotPasswordUseCase(this.authRepo);

  Future<Result<void>> call(String email) {
    return authRepo.forgetPassword(email);
  }
}
