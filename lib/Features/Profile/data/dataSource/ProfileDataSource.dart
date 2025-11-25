
import 'package:online_exam/Features/Profile/domain/model/UserModel.dart';
import 'package:online_exam/Features/result.dart';

abstract class ProfileDataSource {

  Future<Result<UserModel>> getUserProfile();

}
