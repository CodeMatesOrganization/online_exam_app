import 'package:dio/dio.dart';
import 'package:online_exam/Features/Subject/api/model/response/ExamsRseponse.dart';
import 'package:online_exam/Features/Subject/api/model/response/SubjectByIdResponse.dart';
import 'package:online_exam/Features/Subject/api/model/response/SubjectsResponse.dart';


import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://exam.elevateegy.com/api/v1/')

abstract class HomeApiClient {

  factory HomeApiClient(Dio dio, {String? baseUrl }) = _HomeApiClient;
  @GET('subjects')
  Future<SubjectsResponse> getAllSubjects ();

  @GET('subjects/{subjectId}')
  Future<SubjectByIdResponse> getSubjectById (
      @Path('subjectId') String subjectId,
      );


  @GET('exams')
  Future<ExamsRseponse> getAllExamsOnSubjects (
      @Query("subject") String subjectId
      );

}