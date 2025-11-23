import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';

abstract class SubjectState {}

class SubjectInitialState extends SubjectState {}
class SubjectLoadingState extends SubjectState {}
class SubjectSuccessState extends SubjectState {
  final List<SubjectModel> subjects;
  SubjectSuccessState(this.subjects);
}
class SubjectErrorState extends SubjectState {
  final Exception exception;
  SubjectErrorState(this.exception);
}
class NavigateToSubjectState extends SubjectState {}

// Intents
abstract class SubjectIntent {}
class NavigateToSubjectIntent extends SubjectIntent {}
