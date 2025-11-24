import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Subject/domain/model/ExamModel.dart';
import 'package:online_exam/Features/Subject/domain/repositories/HomeRepo.dart';
import 'package:online_exam/Features/Subject/domain/result.dart';
import 'package:online_exam/Features/Subject/ui/Exams/ExamsContract.dart';
import 'package:online_exam/core/SharedPref.dart';
import 'package:online_exam/di.dart';

@injectable
class ExamsViewModel extends Cubit<ExamsState> {
  final HomeRepo homeRepo;
  final SharedPreferencesHelper _prefs;


  ExamsViewModel(this.homeRepo , this._prefs) : super(ExamsInitialState()) {
    fetchExams();
  }

  void doIntent(ExamsIntent intent) async {

  }

  Future<void> fetchExams() async {
    emit(ExamsLoadingState());
    final savedId = await  getIt<SharedPreferencesHelper>().getSubjectId();

    var result = await homeRepo.getAllExamsOnSubject(savedId!);

    if (result is Success<List<ExamModel>>) {
      final exams = result.data;
      emit(ExamsSuccessState(exams));
    } else if (result is Failure<List<ExamModel>>) {
      final exception = result.exception;
      emit(ExamsErrorState(exception));
    }
  }
}

