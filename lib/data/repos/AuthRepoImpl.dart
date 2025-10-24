import 'package:online_exam/api/model/request/sign_up_request.dart';
import 'package:online_exam/data/dataSource/AuthOnlineDataSource.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';

import '../../domain/model/UserModel.dart';

class AuthRepoImpl implements AuthRepo {

    AuthOnlineDataSource authOnlineDataSource;

    AuthRepoImpl(this.authOnlineDataSource);

  @override
  Future<Result<UserModel>> login(String email ,String password) {
    return authOnlineDataSource.login(
       email ,
        password);
  }

  @override
  Future<Result<UserModel>> signUp(SignUpRequest request) {
    return authOnlineDataSource.signUp(
       request
        );

  }

}