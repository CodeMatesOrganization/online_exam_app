import 'package:online_exam/Features/Questions/api/model/request/submit_exam_request.dart';
import 'package:online_exam/Features/Questions/api/model/response/check_questions_response.dart';

abstract class CheckQuestionsRepo {
  Future<CheckQuestionsResponse> checkQuestions({
    required SubmitExamRequest request,
    required String token,
  });
}

