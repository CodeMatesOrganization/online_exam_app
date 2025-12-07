import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Profile/api/model/request/editRequest.dart';
import 'package:online_exam/Features/Profile/domain/model/EditProfileModel.dart';
import 'package:online_exam/Features/Profile/domain/model/UserModel.dart';
import 'package:online_exam/Features/Profile/domain/repositories/ProfileRepo.dart';
import 'package:online_exam/Features/result.dart';
import 'package:online_exam/Features/Profile/data/dataSource/ProfileDataSource.dart';




@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {

  ProfileDataSource profileDataSource;

  ProfileRepoImpl(this.profileDataSource);

  @override
  Future<Result<UserModel>> getUserProfile() {
    return profileDataSource.getUserProfile();
  }

  @override
  Future<Result<EditProfileModel>> editUserProfile(EditRequest user) {
    return profileDataSource.editUserProfile(user);

  }

  @override
  Future<Result<void>> logOut() {
    return profileDataSource.logOut();

  }


}