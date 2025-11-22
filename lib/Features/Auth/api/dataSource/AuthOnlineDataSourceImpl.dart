import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Auth/api/api_client.dart';
import 'package:online_exam/Features/Auth/api/api_utils.dart';
import 'package:online_exam/Features/Auth/api/model/request/login_request.dart';
import 'package:online_exam/Features/Auth/api/model/request/sign_up_request.dart';
import 'package:online_exam/Features/Auth/data/dataSource/AuthOnlineDataSource.dart';
import 'package:online_exam/Features/Auth/domain/model/UserModel.dart';
import 'package:online_exam/Features/Auth/domain/result.dart';


@Injectable(as: AuthOnlineDataSource)
class AuthOnlineDataSourceImpl implements AuthOnlineDataSource {
  ApiClient apiClient;

  AuthOnlineDataSourceImpl(this.apiClient);

  @override
  Future<Result<UserModel>> login(LoginRequest request) {
    return executeApi<UserModel>(() async {
      final response = await apiClient.login(request);
      return response.user!.toUserModel();
    });
  }

  @override
  Future<Result<UserModel>> signUp(SignUpRequest request) {
    return executeApi<UserModel>(() async {
      final response = await apiClient.signUp(request);
      return response.user!.toUserModel();
    });
  }

  @override
  Future<Result<void>> forgetPassword(String email) {
    return executeApi<void>(() async {
      await apiClient.forgotPassword({"email": email});
      return null;
    });
  }

  @override
  Future<Result<void>> emailVerification(String resetCode) {
    return executeApi<void>(() async {
      await apiClient.verifyResetCode({"resetCode": resetCode});
      return null;
    });
  }

  @override
  Future<Result<void>> resetPassword(String email, String newPassword) {
    return executeApi<void>(() async {
      await apiClient.resetPassword({
        "email": email,
        "newPassword": newPassword,
      });
      return null;
    });
  }
}
