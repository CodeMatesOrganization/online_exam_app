import 'package:dio/dio.dart';
import 'package:online_exam/Features/Auth/api/model/request/login_request.dart';
import 'package:online_exam/Features/Auth/api/model/request/sign_up_request.dart';
import 'package:online_exam/Features/Auth/api/model/response/auth_response.dart';
import 'package:online_exam/Features/Questions/api/model/request/submit_exam_request.dart';
import 'package:online_exam/Features/Questions/api/model/response/check_questions_response.dart';
import 'package:online_exam/Features/Questions/api/model/response/questions_response.dart';


import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';


@RestApi(baseUrl: 'https://exam.elevateegy.com/api/v1/')

abstract class ApiClient {

  factory ApiClient(Dio dio, {String? baseUrl }) = _ApiClient;
  @POST('auth/signin')
  Future<AuthResponse> login (@Body() LoginRequest request
      );

  @POST('auth/signup')

  Future<AuthResponse> signUp(@Body() SignUpRequest request);

  @POST("auth/forgotPassword")
  Future<void> forgotPassword(@Body() Map<String, dynamic> body);

  @POST("auth/verifyResetCode")
  Future<void> verifyResetCode(@Body() Map<String, dynamic> body);

  @PUT("auth/resetPassword")
  Future<void> resetPassword(@Body() Map<String, dynamic> body);

  @GET("questions?exam={id}")
  Future<QuestionsResponse> getExamById({
    @Path("id") required String examId,
    @Header("token") required String? token,
  });

  @POST("questions/check")
  Future<CheckQuestionsResponse> checkQuestions({
    @Body() required SubmitExamRequest request,
    @Header("token") required String? token,
  });
}