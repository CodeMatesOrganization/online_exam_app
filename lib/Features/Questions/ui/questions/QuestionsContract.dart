import 'package:equatable/equatable.dart';
import 'package:online_exam/Features/Questions/api/model/response/check_questions_response.dart';
import 'package:online_exam/Features/Questions/api/model/response/questions_response.dart';

// -----------------------------------------------------------------------------
//                               INTENTS
// -----------------------------------------------------------------------------

abstract class QuestionsIntent {}

class LoadExamQuestions extends QuestionsIntent {
  final String examId;
  LoadExamQuestions(this.examId);
}

class SelectAnswerIntent extends QuestionsIntent {
  final int questionIndex;
  final int answerIndex;
  SelectAnswerIntent(this.questionIndex, this.answerIndex);
}

class SubmitExamIntent extends QuestionsIntent {}


// -----------------------------------------------------------------------------
//                               STATES
// -----------------------------------------------------------------------------

abstract class QuestionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuestionsLoadingState extends QuestionsState {}

class QuestionsErrorState extends QuestionsState {
  final String message;
  QuestionsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class QuestionsLoadedState extends QuestionsState {
  final QuestionsResponse exam;
  final int currentIndex;
  final List<int?> selectedAnswers;
  final String formattedTime;

  QuestionsLoadedState({
    required this.exam,
    required this.currentIndex,
    required this.selectedAnswers,
    required this.formattedTime,
  });

  @override
  List<Object?> get props =>
      [exam, currentIndex, selectedAnswers, formattedTime];
}

class QuestionsAnswerSelectedState extends QuestionsState {}
class QuestionsNextPrevState extends QuestionsState {}
class QuestionsTimerTickState extends QuestionsState {}
class TimeoutState extends QuestionsState {}


// ---------------------------- RESULT STATE -----------------------------

class NavigateToResultState extends QuestionsState {
  final String? total;
  final int? correct;
  final int? wrong;

  final List<CorrectQuestions> correctQuestions;
  final List<WrongQuestions> wrongQuestions;

  NavigateToResultState({
    this.total,
    this.correct,
    this.wrong,
    required this.correctQuestions,
    required this.wrongQuestions,
  });

  @override
  List<Object?> get props => [
    total,
    correct,
    wrong,
    correctQuestions,
    wrongQuestions,
  ];
}
