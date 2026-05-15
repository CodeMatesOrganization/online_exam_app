import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Subject/domain/model/ExamModel.dart';
import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';
import 'package:online_exam/Features/Subject/domain/repositories/HomeRepo.dart';
import 'package:online_exam/Features/Subject/domain/result.dart';
import 'package:online_exam/Features/Subject/ui/Exams/ExamsContract.dart';
import 'package:online_exam/core/SharedPref.dart';

@injectable
class ExamsViewModel extends Cubit<ExamsState> {
  final HomeRepo homeRepo;
  final SharedPreferencesHelper _prefs;
  String? subjectName;


  ExamsViewModel(this.homeRepo , this._prefs) : super(ExamsInitialState()) {
    fetchExams();
  }

  void doIntent(ExamsIntent intent) async {

  }

  Future<void> fetchExams() async {

    emit(ExamsLoadingState());


    final savedId = await _prefs.getSubjectId();
    if (savedId == null) {
      emit(ExamsErrorState(Exception("Subject ID not found")));
      return;
    }

    var subjectResult = await homeRepo.getSubjectById(savedId);
    if (subjectResult is Success<SubjectModel>) {
      subjectName = subjectResult.data.name;

    }else if (subjectResult is Failure<SubjectModel>) {
    }

    var examResult = await homeRepo.getAllExamsOnSubject(savedId);
    // var examResult = await homeRepo.getAllExamsOnSubject("670070a830a3c3c1944a9c63");

    if (examResult is Success<List<ExamModel>>) {
      final exams = examResult.data;
      emit(ExamsSuccessState(exams , subjectName ));
    } else if (examResult is Failure<List<ExamModel>>) {
      final exception = examResult.exception;
      emit(ExamsErrorState(exception));
    }
  }
}

