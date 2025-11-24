
import 'package:online_exam/Features/Subject/domain/model/ExamModel.dart';
import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';
import 'package:online_exam/Features/Subject/domain/result.dart';

abstract class HomeOnlineDataSource {
  Future<Result<List<SubjectModel>>> getAllSubjects();
  Future<Result<List<ExamModel>>> getAllExamsOnSubjects(String subjectId);

}
