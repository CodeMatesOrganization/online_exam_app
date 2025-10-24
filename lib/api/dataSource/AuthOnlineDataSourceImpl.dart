import 'package:online_exam/data/dataSource/AuthOnlineDataSource.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/result.dart';

class AuthOnlineDataSourceImpl implements AuthOnlineDataSource {
  @override
  Future<Result<UserModel>> login(email, password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Result<UserModel>> signUp(request) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

}
