import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
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
      emit(UpdateProfile());
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
}

