// QuestionsViewModel.dart

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:online_exam/Features/Auth/domain/result.dart';
import 'package:online_exam/Features/Questions/api/model/request/submit_exam_request.dart';
import 'package:online_exam/Features/Questions/api/model/response/questions_response.dart' hide Answers;

import 'package:online_exam/Features/Questions/domain/repositories/QuestionsRepo.dart';
import 'package:online_exam/Features/Questions/domain/useCase/CheckQuestionsUseCase.dart';
import 'package:online_exam/Features/Result/ResultPref.dart';
import 'package:online_exam/Features/Result/model/ExamResultModel.dart';

import 'QuestionsContract.dart';

@injectable
class QuestionsViewModel extends Cubit<QuestionsState> {
  final QuestionRepo repo;
  final CheckQuestionsUseCase checkUseCase;

  QuestionsResponse? exam;
  int currentIndex = 0;
  List<int?> selectedAnswers = [];

  int totalSeconds = 0;
  Timer? timer;

  QuestionsViewModel(this.repo, this.checkUseCase)
      : super(QuestionsLoadingState());

  String get formattedTime {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  // Dispatcher
  void doIntent(QuestionsIntent intent) {
    if (intent is LoadExamQuestions) {
      _loadExam(intent.examId);
    } else if (intent is SelectAnswerIntent) {
      _selectAnswer(intent.questionIndex, intent.answerIndex);
    } else if (intent is SubmitExamIntent) {
      _submitExam();
    }
  }

  // Load Exam
  Future<void> _loadExam(String id) async {
    emit(QuestionsLoadingState());

    final result = await repo.getQuestionsForExam(examId: id);
    if (result is Success<QuestionsResponse>) {
      exam = result.data;
      selectedAnswers = List.filled(exam!.questions!.length, null);

      totalSeconds = exam!.questions!.first.exam!.duration! * 60;
     //  totalSeconds = 10;

      _startTimer();

      _emitLoadedState();
    } else {
      emit(QuestionsErrorState("Error loading exam"));
    }
  }

  // Select Answer
  void _selectAnswer(int qIndex, int ansIndex) {
    selectedAnswers[qIndex] = ansIndex;
    _emitLoadedState();
  }

  // Navigation
  void nextQuestion() {
    if (currentIndex < exam!.questions!.length - 1) {
      currentIndex++;
      _emitLoadedState();
    }
  }

  void prevQuestion() {
    if (currentIndex > 0) {
      currentIndex--;
      _emitLoadedState();
    }
  }

  // Timer
  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (totalSeconds == 0) {
        t.cancel();
        emit(TimeoutState());
        return;
      }

      totalSeconds--;
      _emitLoadedState();
    });
  }

  // Emit Loaded State
  void _emitLoadedState() {
    emit(
      QuestionsLoadedState(
        exam: exam!,
        currentIndex: currentIndex,
        selectedAnswers: selectedAnswers,
        formattedTime: formattedTime,
      ),
    );
  }

  // Submit Exam
  Future<void> _submitExam() async {
    timer?.cancel();
    emit(QuestionsLoadingState());

    try {
      final answersList = List.generate(exam!.questions!.length, (i) {
        final ansIndex = selectedAnswers[i];
        final key = ansIndex != null
            ? exam!.questions![i].answers![ansIndex].key
            : null;

        return Answers(
          questionId: exam!.questions![i].Id,
          correct: key,
        );
      });

      final request = SubmitExamRequest(
        answers: answersList,
        time: exam!.questions!.first.exam!.duration! * 60 - totalSeconds,
      );

      final token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4Zjk3NzhlOGZiMTlhZDk1NWIyMzQzMiIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzY0ODc5NjQ2fQ.hJWlu9V_871V82paaz7Ge8GEf_gVmS5gcz32vRlE5Aw';

      final response = await checkUseCase(
        request: request,
        token: token,
      );
      await ResultStorageService.saveExamResult(
        ExamResultModel(
          title: exam!.questions!.first.exam!.title ?? "Exam",
          correct: response.correct,
          wrong: response.wrong,
          totalQuestions: exam!.questions!.length,
          date: DateTime.now(),
          correctQuestions: response.correctQuestions ?? [],
          wrongQuestions: response.wrongQuestions ?? [],
          allQuestions: exam!.questions!.map((e) => e.toJson()).toList(),
        ),
      );

      emit(
        NavigateToResultState(
          total: response.total ?? "0",
          correct: response.correct,
          wrong: response.wrong,
          correctQuestions: response.correctQuestions ?? [],
          wrongQuestions: response.wrongQuestions ?? [],
        ),
      );
    } catch (e) {
      emit(QuestionsErrorState("Error submitting exam: $e"));
    }
  }
}
