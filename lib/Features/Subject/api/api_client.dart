import 'package:dio/dio.dart';
import 'package:online_exam/Features/Subject/api/model/response/SubjectsResponse.dart';


import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://exam.elevateegy.com/api/v1/')

abstract class HomeApiClient {

  factory HomeApiClient(Dio dio, {String? baseUrl }) = _HomeApiClient;
  @GET('subjects')
  Future<SubjectsResponse> getAllSubjects ();

 }