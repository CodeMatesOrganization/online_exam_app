import 'package:online_exam/Features/Auth/domain/model/UserModel.dart';


class AuthResponseModel {
  final String? message;
  final String? token;
  final UserModel? user;

  AuthResponseModel ({
    this.message,
    this.token,
    this.user,
  });

}


