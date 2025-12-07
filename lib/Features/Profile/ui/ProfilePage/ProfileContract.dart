import 'package:online_exam/Features/Profile/domain/model/UserModel.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}
class ProfileLoadingState extends ProfileState {}
class ProfileSuccessState extends ProfileState {

  final UserModel user;
  ProfileSuccessState(this.user);
}
class ProfileErrorState extends ProfileState {
  final Exception exception;
  ProfileErrorState(this.exception);
}
class UpdateProfile extends ProfileState {}

class UpdateProfileLoadingState extends ProfileState {}

class UpdateProfileSuccessState extends ProfileState {
  final UserModel user;
  UpdateProfileSuccessState(this.user);
}

class UpdateProfileErrorState extends ProfileState {
  final Exception exception;
  UpdateProfileErrorState(this.exception);
}
class LogOutState extends ProfileState{

}




abstract class ProfileIntent {}

class UpdateProfileIntent extends ProfileIntent {
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  UpdateProfileIntent({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });
}
class LogOutIntent extends ProfileIntent{

}
