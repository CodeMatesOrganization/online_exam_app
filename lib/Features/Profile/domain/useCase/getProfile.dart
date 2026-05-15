
import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Profile/domain/model/UserModel.dart';
import 'package:online_exam/Features/Profile/domain/repositories/ProfileRepo.dart';
import 'package:online_exam/Features/result.dart';

@injectable
class GetProfile {

  final ProfileRepo profileRepo;

  GetProfile(this.profileRepo);

  Future<Result<UserModel>> invoke() {
    return profileRepo.getUserProfile();
  }
}
