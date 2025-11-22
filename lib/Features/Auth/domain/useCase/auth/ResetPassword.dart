import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Auth/domain/repositories/AuthRepo.dart';
import 'package:online_exam/Features/Auth/domain/result.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo authRepo;

  ResetPasswordUseCase(this.authRepo);

  Future<Result<void>> call(String email, String newPassword) {
    return authRepo.resetPassword(email, newPassword);
  }
}
