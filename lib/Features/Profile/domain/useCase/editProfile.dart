
import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Profile/api/model/request/editRequest.dart';
import 'package:online_exam/Features/Profile/domain/model/EditProfileModel.dart';
import 'package:online_exam/Features/Profile/domain/repositories/ProfileRepo.dart';
import 'package:online_exam/Features/result.dart';

@injectable
class EditProfile {

  final ProfileRepo profileRepo;

  EditProfile(this.profileRepo);

  Future<Result<EditProfileModel>> invoke(EditRequest user) {
    return profileRepo.editUserProfile(user);
  }
}
