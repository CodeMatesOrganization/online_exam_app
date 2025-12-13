import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Auth/api/model/request/login_request.dart';
import 'package:online_exam/Features/Auth/api/model/request/sign_up_request.dart';
import 'package:online_exam/Features/Auth/data/dataSource/AuthOnlineDataSource.dart';
import 'package:online_exam/Features/Auth/domain/repositories/AuthRepo.dart';
import 'package:online_exam/Features/Auth/domain/result.dart';
import 'package:online_exam/Features/Auth/domain/model/AuthResponseModel.dart';



@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {

    AuthOnlineDataSource authOnlineDataSource;

    AuthRepoImpl(this.authOnlineDataSource);

  @override
  Future<Result<AuthResponseModel>> login(LoginRequest request) {
    return authOnlineDataSource.login(
       request);
  }

  @override
  Future<Result<AuthResponseModel>> signUp(SignUpRequest request) {
    return authOnlineDataSource.signUp(
       request
        );

  }

    @override
    Future<Result<void>> forgetPassword(String email) {
      return authOnlineDataSource.forgetPassword(email);
    }

    @override
    Future<Result<void>> emailVerification(String resetCode) {
      return authOnlineDataSource.emailVerification(resetCode);
    }

    @override
    Future<Result<void>> resetPassword(String email, String newPassword) {
      return authOnlineDataSource.resetPassword(email, newPassword);
    }
}