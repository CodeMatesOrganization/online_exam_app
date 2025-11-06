import 'package:injectable/injectable.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';

@injectable
class EmailVerificationUseCase {
  final AuthRepo authRepo;

  EmailVerificationUseCase(this.authRepo);

  Future<Result<void>> call(String email, String newPassword) {
    return authRepo.resetPassword(email, newPassword);
  }
}
