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

abstract class ProfileIntent {}

class UpdateProfileIntent extends ProfileIntent {

}
