import 'package:injectable/injectable.dart';
import 'package:online_exam/api/model/request/sign_up_request.dart';
import 'package:online_exam/data/dataSource/AuthOnlineDataSource.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';


@Injectable(as: AuthRepo)
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