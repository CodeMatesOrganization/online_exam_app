import 'package:dio/dio.dart';
import 'package:online_exam/api/model/request/sign_up_request.dart';
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
  Future<AuthResponse> signUp(@Body() SignUpRequest request);


}