import 'package:dio/dio.dart';
import 'package:online_exam/api/model/response/auth_response.dart';

import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://exam.elevateegy.com/api/v1/')

abstract class ApiClient {

  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;
  @POST('auth/signin')
  Future<AuthResponse> login ({
    @Query("email") required String email,
    @Query("password") required String password}
      );

  @POST('auth/signup')
  Future<AuthResponse> signUp({
    @Field("username") required String userName,
    @Field("firstName") required String firstName,
    @Field("lastName") required String lastName,
    @Field("email") required String email,
    @Field("password") required String password,
    @Field("confirmPassword") required String confirmPassword,
    @Field("phone") required String phoneNumber,
  });

}