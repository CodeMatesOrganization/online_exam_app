import 'package:injectable/injectable.dart';
import 'package:online_exam/api/model/request/login_request.dart';
import 'package:online_exam/api/model/request/sign_up_request.dart';
import 'package:online_exam/data/dataSource/AuthOnlineDataSource.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';


@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {

    AuthOnlineDataSource authOnlineDataSource;

    AuthRepoImpl(this.authOnlineDataSource);

  @override
  Future<Result<UserModel>> login(LoginRequest request) {
    return authOnlineDataSource.login(
       request);
  }

  @override
  Future<Result<UserModel>> signUp(SignUpRequest request) {
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