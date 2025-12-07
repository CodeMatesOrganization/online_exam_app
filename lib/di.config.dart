// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import 'core/SharedPref.dart' as _i411;
import 'Features/Auth/api/api_client.dart' as _i202;
import 'Features/Auth/api/dataSource/AuthOnlineDataSourceImpl.dart' as _i749;
import 'Features/Auth/data/dataSource/AuthOnlineDataSource.dart' as _i648;
import 'Features/Auth/data/repos/AuthRepoImpl.dart' as _i248;
import 'Features/Auth/domain/repositories/AuthRepo.dart' as _i894;
import 'Features/Auth/domain/useCase/auth/EmailVerification.dart' as _i746;
import 'Features/Auth/domain/useCase/auth/ForgotPassword.dart' as _i344;
import 'Features/Auth/domain/useCase/auth/Login.dart' as _i292;
import 'Features/Auth/domain/useCase/auth/ResetPassword.dart' as _i271;
import 'Features/Auth/domain/useCase/auth/SignUp.dart' as _i949;
import 'Features/Auth/ui/auth/forgetPassword/ForgetPasswordViewModel.dart'
    as _i77;
import 'Features/Auth/ui/auth/login/LoginViewModel.dart' as _i748;
import 'Features/Auth/ui/auth/resetPassword/ResetPasswordViewModel.dart'
    as _i440;
import 'Features/Auth/ui/auth/signUp/SignUpViewModel.dart' as _i958;
import 'Features/Auth/ui/auth/verifyCode/VerifyCode.dart' as _i200;
import 'Features/Auth/ui/auth/verifyCode/VerifyViewModel.dart' as _i631;
import 'Features/di.dart' as _i72;
import 'Features/Profile/api/api_client.dart' as _i644;
import 'Features/Profile/api/dataSource/ProfileOnlineDataSourceImpl.dart'
    as _i878;
import 'Features/Profile/data/dataSource/ProfileDataSource.dart' as _i656;
import 'Features/Profile/data/repos/ProfileRepoImpl.dart' as _i449;
import 'Features/Profile/domain/repositories/ProfileRepo.dart' as _i563;
import 'Features/Profile/domain/useCase/editProfile.dart' as _i801;
import 'Features/Profile/domain/useCase/getProfile.dart' as _i33;
import 'Features/Profile/ui/ProfilePage/ProfileViewModel.dart' as _i346;
import 'Features/Subject/api/api_client.dart' as _i464;
import 'Features/Subject/api/dataSource/HomeOnlineDataSourceImpl.dart' as _i452;
import 'Features/Subject/data/dataSource/HomeOnlineDataSource.dart' as _i530;
import 'Features/Subject/data/repos/HomeRepoImpl.dart' as _i191;
import 'Features/Subject/domain/repositories/HomeRepo.dart' as _i494;
import 'Features/Subject/domain/useCase/Exams.dart' as _i484;
import 'Features/Subject/domain/useCase/Subject.dart' as _i193;
import 'Features/Subject/domain/useCase/SubjectById.dart' as _i1031;
import 'Features/Subject/ui/Exams/ExamsViewModel.dart' as _i1004;
import 'Features/Subject/ui/Subjects/SubjectViewModel.dart' as _i1039;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    gh.factory<_i200.VerifyCode>(() => const _i200.VerifyCode());
    gh.singleton<_i528.PrettyDioLogger>(() => apiModule.provideDioLogger());
    gh.singleton<_i361.BaseOptions>(() => apiModule.provideOptions());
    gh.singleton<_i411.SharedPreferencesHelper>(
      () => _i411.SharedPreferencesHelper(),
    );
    gh.singleton<_i361.Dio>(
      () => apiModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i528.PrettyDioLogger>(),
        gh<_i411.SharedPreferencesHelper>(),
      ),
    );
    gh.singleton<_i202.ApiClient>(
      () => apiModule.provideApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i464.HomeApiClient>(
      () => apiModule.provideHomeApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i644.ProfileApiClient>(
      () => apiModule.provideProfileApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i656.ProfileDataSource>(
      () => _i878.ProfileOnlineDataSourceImpl(gh<_i644.ProfileApiClient>()),
    );
    gh.factory<_i530.HomeOnlineDataSource>(
      () => _i452.HomeOnlineDataSourceImpl(gh<_i464.HomeApiClient>()),
    );
    gh.factory<_i563.ProfileRepo>(
      () => _i449.ProfileRepoImpl(gh<_i656.ProfileDataSource>()),
    );
    gh.factory<_i648.AuthOnlineDataSource>(
      () => _i749.AuthOnlineDataSourceImpl(gh<_i202.ApiClient>()),
    );
    gh.factory<_i894.AuthRepo>(
      () => _i248.AuthRepoImpl(gh<_i648.AuthOnlineDataSource>()),
    );
    gh.factory<_i801.EditProfile>(
      () => _i801.EditProfile(gh<_i563.ProfileRepo>()),
    );
    gh.factory<_i33.GetProfile>(() => _i33.GetProfile(gh<_i563.ProfileRepo>()));
    gh.factory<_i346.ProfileViewModel>(
      () => _i346.ProfileViewModel(gh<_i563.ProfileRepo>()),
    );
    gh.factory<_i746.EmailVerificationUseCase>(
      () => _i746.EmailVerificationUseCase(gh<_i894.AuthRepo>()),
    );
    gh.factory<_i344.ForgotPasswordUseCase>(
      () => _i344.ForgotPasswordUseCase(gh<_i894.AuthRepo>()),
    );
    gh.factory<_i292.LoginUseCase>(
      () => _i292.LoginUseCase(gh<_i894.AuthRepo>()),
    );
    gh.factory<_i271.ResetPasswordUseCase>(
      () => _i271.ResetPasswordUseCase(gh<_i894.AuthRepo>()),
    );
    gh.factory<_i949.SignupUseCase>(
      () => _i949.SignupUseCase(gh<_i894.AuthRepo>()),
    );
    gh.factory<_i77.ForgetPasswordViewModel>(
      () => _i77.ForgetPasswordViewModel(gh<_i894.AuthRepo>()),
    );
    gh.factory<_i748.LoginViewModel>(
      () => _i748.LoginViewModel(gh<_i894.AuthRepo>()),
    );
    gh.factory<_i440.ResetPasswordViewModel>(
      () => _i440.ResetPasswordViewModel(gh<_i894.AuthRepo>()),
    );
    gh.factory<_i958.SignUpViewModel>(
      () => _i958.SignUpViewModel(gh<_i894.AuthRepo>()),
    );
    gh.factory<_i631.VerifyViewModel>(
      () => _i631.VerifyViewModel(gh<_i894.AuthRepo>()),
    );
    gh.factory<_i494.HomeRepo>(
      () => _i191.HomeRepoImpl(gh<_i530.HomeOnlineDataSource>()),
    );
    gh.factory<_i1004.ExamsViewModel>(
      () => _i1004.ExamsViewModel(
        gh<_i494.HomeRepo>(),
        gh<_i411.SharedPreferencesHelper>(),
      ),
    );
    gh.factory<_i484.SubjectUseCase>(
      () => _i484.SubjectUseCase(gh<_i494.HomeRepo>()),
    );
    gh.factory<_i193.SubjectUseCase>(
      () => _i193.SubjectUseCase(gh<_i494.HomeRepo>()),
    );
    gh.factory<_i1031.SubjectByIdUseCase>(
      () => _i1031.SubjectByIdUseCase(gh<_i494.HomeRepo>()),
    );
    gh.factory<_i1039.SubjectViewModel>(
      () => _i1039.SubjectViewModel(gh<_i494.HomeRepo>()),
    );
    return this;
  }
}

class _$ApiModule extends _i72.ApiModule {}
