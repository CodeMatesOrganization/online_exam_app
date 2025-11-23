
import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';
import 'package:online_exam/Features/Subject/domain/result.dart';

abstract class HomeOnlineDataSource {
  Future<Result<List<SubjectModel>>> getAllSubjects();
}
