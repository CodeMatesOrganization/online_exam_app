
import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';
import 'package:online_exam/Features/Subject/domain/repositories/HomeRepo.dart';
import 'package:online_exam/Features/Subject/domain/result.dart';

@injectable
class SubjectUseCase {
  final HomeRepo homeRepo;

  SubjectUseCase(this.homeRepo);

  Future<Result<List<SubjectModel>>> invoke() {
    return homeRepo.getAllSubjects();
  }
}
