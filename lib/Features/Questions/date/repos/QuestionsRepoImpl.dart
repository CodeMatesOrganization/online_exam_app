import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Auth/domain/result.dart';
import 'package:online_exam/Features/Questions/api/model/response/questions_response.dart';
import 'package:online_exam/Features/Questions/date/dataSource/QuestionsOnlineDataSource.dart';
import 'package:online_exam/Features/Questions/domain/repositories/QuestionsRepo.dart';
import 'package:online_exam/core/local/Prefrence.dart';

@Injectable(as: QuestionRepo)
class QuestionsRepoImpl implements QuestionRepo {
  final QuestionsOnlineDataSource questionsOnlineDataSource;

  QuestionsRepoImpl(this.questionsOnlineDataSource);

  @override
  Future<Result<QuestionsResponse>> getQuestionsForExam({required String examId}) async {
    return await questionsOnlineDataSource.getQuestions(examId: examId , token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4Zjk3NzhlOGZiMTlhZDk1NWIyMzQzMiIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzY0ODc5NjQ2fQ.hJWlu9V_871V82paaz7Ge8GEf_gVmS5gcz32vRlE5Aw");
  }
}