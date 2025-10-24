import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/result.dart';

abstract class AuthOnlineDataSource {


  Future<Result<UserModel>> login(
      email  , password);

  Future<Result<UserModel>> signUp(
      request
      );

}