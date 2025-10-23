import 'package:injectable/injectable.dart';
import 'package:online_exam/api/model/request/sign_up_request.dart';
import 'package:online_exam/domain/model/UserModel.dart';
import 'package:online_exam/domain/repositories/AuthRepo.dart';
import 'package:online_exam/domain/result.dart';

@Injectable(as: AuthRepo) //put name of abstract class
class AuthRepoImpl implements AuthRepo {

  @override
  Future<Result<UserModel>> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Result<UserModel>> signUp(SignUpRequest request) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

 

}