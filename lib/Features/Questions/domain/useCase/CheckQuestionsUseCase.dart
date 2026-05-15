import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Questions/api/model/request/submit_exam_request.dart';
import 'package:online_exam/Features/Questions/api/model/response/check_questions_response.dart';
import 'package:online_exam/Features/Questions/domain/repositories/CheckQuestionsRepo.dart';

@injectable
class CheckQuestionsUseCase {
  final CheckQuestionsRepo repo;

  CheckQuestionsUseCase(this.repo);

  Future<CheckQuestionsResponse> call({
    required SubmitExamRequest request,
    required String token,
  }) {
    return repo.checkQuestions(request: request, token: token);
  }
}
