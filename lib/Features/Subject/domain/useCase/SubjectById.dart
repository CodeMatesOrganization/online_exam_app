
import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';
import 'package:online_exam/Features/Subject/domain/repositories/HomeRepo.dart';
import 'package:online_exam/Features/Subject/domain/result.dart';

@injectable
class SubjectByIdUseCase {
  final HomeRepo homeRepo;

  SubjectByIdUseCase(this.homeRepo);

  Future<Result<SubjectModel>> invoke(String subjectId) {
    return homeRepo.getSubjectById(subjectId);
  }
}
