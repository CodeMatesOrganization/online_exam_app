import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Questions/api/model/request/submit_exam_request.dart';
import 'package:online_exam/Features/Questions/api/model/response/check_questions_response.dart' hide Answers;
import 'package:online_exam/Features/Questions/date/dataSource/CheckQuestionsDataSource.dart';
import 'package:online_exam/core/api/api_client.dart';

@Injectable(as: CheckQuestionsDataSource)
class CheckQuestionsDataSourceImpl implements CheckQuestionsDataSource {
  final ApiClient _api;

  CheckQuestionsDataSourceImpl(this._api);

  @override
  Future<CheckQuestionsResponse> checkQuestions({
    required SubmitExamRequest request,
    required String token,
  }) async {
    final response = await _api.checkQuestions(
      request: request,
      token: token,
    );

    return response;
  }
}

