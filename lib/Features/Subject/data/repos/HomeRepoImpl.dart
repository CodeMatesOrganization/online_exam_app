import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Subject/data/dataSource/HomeOnlineDataSource.dart';
import 'package:online_exam/Features/Subject/domain/model/ExamModel.dart';
import 'package:online_exam/Features/Subject/domain/repositories/HomeRepo.dart';
import 'package:online_exam/Features/Subject/domain/result.dart';

import '../../domain/model/SubjectModel.dart';


@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {

    HomeOnlineDataSource homeOnlineDataSource;

    HomeRepoImpl(this.homeOnlineDataSource);

  @override
  Future<Result<List<SubjectModel>>> getAllSubjects() {
    return homeOnlineDataSource.getAllSubjects();
  }

    @override
    Future<Result<SubjectModel>> getSubjectById(String subjectId) {
      return homeOnlineDataSource.getSubjectById(subjectId);
    }
  @override
  Future<Result<List<ExamModel>>> getAllExamsOnSubject(String subjectId) {
   return homeOnlineDataSource.getAllExamsOnSubjects(subjectId);
  }

}