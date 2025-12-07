import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Questions/api/model/request/submit_exam_request.dart';
import 'package:online_exam/Features/Questions/api/model/response/check_questions_response.dart';
import 'package:online_exam/Features/Questions/date/dataSource/CheckQuestionsDataSource.dart';
import 'package:online_exam/Features/Questions/domain/repositories/CheckQuestionsRepo.dart';

@Injectable(as: CheckQuestionsRepo)
class CheckQuestionsRepoImpl implements CheckQuestionsRepo {
  final CheckQuestionsDataSource remote;

  CheckQuestionsRepoImpl(this.remote);

  @override
  Future<CheckQuestionsResponse> checkQuestions({
    required SubmitExamRequest request,
    required String token,
  }) {
    return remote.checkQuestions(request: request, token: token);
  }
}

