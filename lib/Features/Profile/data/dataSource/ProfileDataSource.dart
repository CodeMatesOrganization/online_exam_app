import 'package:online_exam/Features/Profile/api/model/request/editRequest.dart';
import 'package:online_exam/Features/Profile/domain/model/EditProfileModel.dart';
import 'package:online_exam/Features/Profile/domain/model/UserModel.dart';
import 'package:online_exam/Features/result.dart';

abstract class ProfileDataSource {

  Future<Result<UserModel>> getUserProfile();
  Future<Result<EditProfileModel>> editUserProfile(EditRequest user);
  Future<Result<void>> logOut();

}
