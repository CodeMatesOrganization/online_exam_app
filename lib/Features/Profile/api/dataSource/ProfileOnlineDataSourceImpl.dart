import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Profile/api/api_client.dart';
import 'package:online_exam/Features/Profile/data/dataSource/ProfileDataSource.dart';
import 'package:online_exam/Features/Profile/domain/model/UserModel.dart';
import 'package:online_exam/Features/result.dart';

import 'package:online_exam/Features/api_utils.dart';


@Injectable(as: ProfileDataSource)
class ProfileOnlineDataSourceImpl implements ProfileDataSource {
  ProfileApiClient apiClient;

  ProfileOnlineDataSourceImpl(this.apiClient);


  @override
  Future<Result<UserModel>> getUserProfile() {
    return executeApi<UserModel>(() async {
      final response = await apiClient.getUserData();
      return response.user!.toUserModel();

    });
  }


}