import 'package:online_exam/api/api_client.dart';
import 'package:online_exam/api/api_utils.dart';
import 'package:online_exam/data/dataSource/AuthOnlineDataSource.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/result.dart';

class AuthOnlineDataSourceImpl implements AuthOnlineDataSource {

  ApiClient apiClient;

  AuthOnlineDataSourceImpl(this.apiClient);

  @override
  Future<Result<UserModel>> login(email, password) {
    return executeApi<UserModel>(() async {
      final response = await apiClient.login(
        email: email,
        password: password,
      );
      return response.user!.toUserModel();
    });
  }

  @override
  Future<Result<UserModel>> signUp(request) {
    return executeApi<UserModel>(() async {
      final response = await apiClient.signUp(
          request
      );
      return response.user!.toUserModel();
    });
  }
}