import 'package:online_exam/Features/Subject/domain/model/ExamModel.dart';
import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';
import 'package:online_exam/Features/Subject/domain/result.dart';

abstract class HomeRepo {
  Future<Result<List<SubjectModel>>> getAllSubjects();
  Future<Result<SubjectModel>> getSubjectById(String subjectId);

  Future<Result<List<ExamModel>>> getAllExamsOnSubject(String subjectId);

}