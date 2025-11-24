import 'package:online_exam/Features/Subject/domain/model/ExamModel.dart';

abstract class ExamsState {}

class ExamsInitialState extends ExamsState {}
class ExamsLoadingState extends ExamsState {}
class ExamsSuccessState extends ExamsState {
  final List<ExamModel> exams;

  ExamsSuccessState(this.exams);
}
class ExamsErrorState extends ExamsState {
  final Exception exception;
  ExamsErrorState(this.exception);
}
class NavigateToExamsState extends ExamsState {}

abstract class ExamsIntent {}

class NavigateToExamsIntent extends ExamsIntent {}
