import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Profile/api/model/request/editRequest.dart';
import 'package:online_exam/Features/Profile/domain/model/EditProfileModel.dart';
import 'package:online_exam/Features/Profile/domain/model/UserModel.dart';
import 'package:online_exam/Features/Profile/domain/repositories/ProfileRepo.dart';
import 'package:online_exam/Features/Profile/ui/ProfilePage/ProfileContract.dart';
import 'package:online_exam/Features/result.dart';


@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileViewModel(this.profileRepo) : super(ProfileInitialState()) {
    fetchUserProfile();
  }

  void doIntent(ProfileIntent intent) async {
    if (intent is UpdateProfileIntent) {
      updateUserProfile(intent);
    }
    if (intent is LogOutIntent) {
      logOut(intent);
    }
  }

  Future<void> fetchUserProfile() async {
    emit(ProfileLoadingState());

    var result = await profileRepo.getUserProfile();

    if (result is Success<UserModel>) {
      final user = result.data;
      emit(ProfileSuccessState(user));
    } else if (result is Failure<UserModel>) {
      final exception = result.exception;
      emit(ProfileErrorState(exception));
    }
  }

  Future<void> updateUserProfile(UpdateProfileIntent intent) async {
    emit(UpdateProfileLoadingState());
    final userProfile = EditRequest(
      firstName: intent.firstName,
      lastName: intent.lastName,
      username: intent.userName,
      email: intent.email,
      phone: intent.phone,
    );

    final result = await profileRepo.editUserProfile(userProfile);

    if (result is Success<EditProfileModel>) {
      final updatedUser = result.data.user; // assuming EditProfileModel يحتوي على user
      emit(UpdateProfileSuccessState(updatedUser!));
      emit(ProfileSuccessState(updatedUser));
    } else if (result is Failure<EditProfileModel>) {
      emit(UpdateProfileErrorState(result.exception));
    }
  }

  Future<void> logOut(LogOutIntent intent) async {

    final result = await profileRepo.logOut();

    if (result is Success<void>) {
      emit(LogOutState());
    } else if (result is Failure<void>) {
      emit(ProfileErrorState(result.exception));
    }
  }

}

