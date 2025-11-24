import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';
import 'package:online_exam/Features/Subject/domain/repositories/HomeRepo.dart';
import 'package:online_exam/Features/Subject/domain/result.dart';
import 'package:online_exam/Features/Subject/ui/Subjects/SubjectContract.dart';
import 'package:online_exam/core/SharedPref.dart';
import 'package:online_exam/di.dart';

@injectable
class SubjectViewModel extends Cubit<SubjectState> {
  final HomeRepo homeRepo;

  SubjectViewModel(this.homeRepo) : super(SubjectInitialState()) {
    fetchSubjects();
  }

  void doIntent(SubjectIntent intent) async {
    if (intent is NavigateToSubjectIntent) {
      emit(NavigateToSubjectState());
      await getIt<SharedPreferencesHelper>().saveSubjectId(intent.subjectId);
    

    }
  }

  Future<void> fetchSubjects() async {
    emit(SubjectLoadingState());

    var result = await homeRepo.getAllSubjects();

    if (result is Success<List<SubjectModel>>) {
      final subjects = result.data;
      emit(SubjectSuccessState(subjects));
    } else if (result is Failure<List<SubjectModel>>) {
      final exception = result.exception;
      emit(SubjectErrorState(exception));
    }
  }
}

