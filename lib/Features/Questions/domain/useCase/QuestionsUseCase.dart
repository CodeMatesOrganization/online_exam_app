import 'package:injectable/injectable.dart' show injectable;
import 'package:online_exam/Features/Auth/domain/result.dart';
import 'package:online_exam/Features/Questions/api/model/response/questions_response.dart';
import 'package:online_exam/Features/Questions/domain/repositories/QuestionsRepo.dart';

@injectable
class QuestionsUseCase {
  final QuestionRepo questionRepo;

  QuestionsUseCase(this.questionRepo);

  Future<Result<QuestionsResponse>> invoke({
    required String examId,
  }) {
    return questionRepo.getQuestionsForExam(
      examId: examId,
    );
  }

}
