import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Profile/api/model/request/editRequest.dart';
import 'package:online_exam/Features/Profile/data/dataSource/ProfileDataSource.dart';
import 'package:online_exam/Features/Profile/domain/model/EditProfileModel.dart';
import 'package:online_exam/Features/Profile/domain/model/UserModel.dart';
import 'package:online_exam/Features/result.dart';

import 'package:online_exam/Features/api_utils.dart';
import 'package:online_exam/core/api/api_client.dart';

@Injectable(as: ProfileDataSource)
class ProfileOnlineDataSourceImpl implements ProfileDataSource {
  ApiClient apiClient;

  ProfileOnlineDataSourceImpl(this.apiClient);

  @override
  Future<Result<UserModel>> getUserProfile() {
    return executeApi<UserModel>(() async {
      final response = await apiClient.getUserData();
      return response.user!.toUserModel();
    });
  }

  @override
  Future<Result<EditProfileModel>> editUserProfile(EditRequest user) {
    return executeApi<EditProfileModel>(() async {
      final response = await apiClient.editUserData(user);
      return response.toUserModel();
    });
  }

  @override
  Future<Result<void>> logOut() {
    return executeApi<void>(() async {
      final response = await apiClient.logOut();
      return response;
    });
  }
}
