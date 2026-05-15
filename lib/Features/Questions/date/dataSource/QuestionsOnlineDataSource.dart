import 'package:online_exam/Features/Auth/domain/result.dart';
import 'package:online_exam/Features/Questions/api/model/response/questions_response.dart';

abstract class QuestionsOnlineDataSource {
  Future<Result<QuestionsResponse>> getQuestions({
    required String examId,
    required String token
  });
}
