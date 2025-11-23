import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';
import 'package:online_exam/Features/Subject/domain/result.dart';

abstract class HomeRepo {
  Future<Result<List<SubjectModel>>> getAllSubjects();
}