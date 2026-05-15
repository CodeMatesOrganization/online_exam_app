import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Auth/domain/result.dart';
import 'package:online_exam/Features/Questions/api/model/response/questions_response.dart';
import 'package:online_exam/Features/Questions/date/dataSource/QuestionsOnlineDataSource.dart';
import 'package:online_exam/core/api/api_client.dart';

@Injectable(as: QuestionsOnlineDataSource)
class QuestionsOnlineDataSourceImpl implements QuestionsOnlineDataSource {
  final ApiClient _client;

  QuestionsOnlineDataSourceImpl(this._client);

  @override
  Future<Result<QuestionsResponse>> getQuestions({
    required String examId,
    required String token,
  }) async {
    try {
      final response = await _client.getExamById(
        token: token,
        examId: examId,
      );

      return Success(response);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}
