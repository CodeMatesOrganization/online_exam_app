// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

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

import 'api/api_client.dart' as _i332;
import 'api/api_module.dart' as _i95;
import 'api/dataSource/AuthOnlineDataSourceImpl.dart' as _i1055;
import 'data/dataSource/AuthOnlineDataSource.dart' as _i731;
import 'data/repos/AuthRepoImpl.dart' as _i333;
import 'domain/repositories/AuthRepo.dart' as _i620;
import 'domain/useCase/auth/Login.dart' as _i629;
import 'domain/useCase/auth/SignUp.dart' as _i425;
import 'ui/auth/login/LoginViewModel.dart' as _i905;
import 'ui/auth/signUp/SignUpViewModel.dart' as _i584;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final apiModule = _$ApiModule();
    gh.singleton<_i528.PrettyDioLogger>(() => apiModule.provideDioLogger());
    gh.singleton<_i361.BaseOptions>(() => apiModule.provideOptions());
    gh.singleton<_i361.Dio>(() => apiModule.provideDio(
          gh<_i361.BaseOptions>(),
          gh<_i528.PrettyDioLogger>(),
        ));
    gh.singleton<_i332.ApiClient>(
        () => apiModule.providerApiClient(gh<_i361.Dio>()));
    gh.factory<_i731.AuthOnlineDataSource>(
        () => _i1055.AuthOnlineDataSourceImpl(gh<_i332.ApiClient>()));
    gh.factory<_i620.AuthRepo>(
        () => _i333.AuthRepoImpl(gh<_i731.AuthOnlineDataSource>()));
    gh.factory<_i629.LoginUseCase>(
        () => _i629.LoginUseCase(gh<_i620.AuthRepo>()));
    gh.factory<_i425.SignupUseCase>(
        () => _i425.SignupUseCase(gh<_i620.AuthRepo>()));
    gh.factory<_i905.LoginViewModel>(
        () => _i905.LoginViewModel(gh<_i629.LoginUseCase>()));
    gh.factory<_i584.SignUpViewModel>(
        () => _i584.SignUpViewModel(gh<_i425.SignupUseCase>()));
    return this;
  }
}

class _$ApiModule extends _i95.ApiModule {}
