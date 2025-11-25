import 'package:online_exam/Features/Profile/domain/model/UserModel.dart';
import 'package:online_exam/Features/result.dart';

abstract class ProfileRepo {
  Future<Result<UserModel>> getUserProfile();
}