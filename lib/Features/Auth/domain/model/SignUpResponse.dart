
import 'package:online_exam/Features/Auth/domain/model/UserModel.dart';

class SignUpResponse {
  SignUpResponse({
    this.message,
    this.token,
    this.user,});

  String? message;
  String? token;
  UserModel? user;


}