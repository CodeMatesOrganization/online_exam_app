import 'package:dio/dio.dart';
import 'package:online_exam/Features/Profile/api/model/EditUserDto.dart';
import 'package:online_exam/Features/Profile/api/model/request/editRequest.dart';
import 'package:online_exam/Features/Profile/api/model/response/UserDataResponse.dart';


import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://exam.elevateegy.com/api/v1/')

abstract class ProfileApiClient {

  factory ProfileApiClient(Dio dio, {String? baseUrl }) = _ProfileApiClient;
  @GET('auth/profileData')
  Future<UserDataResponse> getUserData ();
  @PUT('auth/editProfile')
  Future<EditUserDto> editUserData (@Body() EditRequest user);
  @GET('auth/logout')
  Future<void> logOut ();


}