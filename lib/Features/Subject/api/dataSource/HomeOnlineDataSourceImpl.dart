import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Subject/api/api_utils.dart';
import 'package:online_exam/Features/Subject/data/dataSource/HomeOnlineDataSource.dart';
import 'package:online_exam/Features/Subject/domain/model/ExamModel.dart';
import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';
import 'package:online_exam/Features/Subject/domain/result.dart';
import 'package:online_exam/core/api/api_client.dart';


@Injectable(as: HomeOnlineDataSource)
class HomeOnlineDataSourceImpl implements HomeOnlineDataSource {
  ApiClient apiClient;

  HomeOnlineDataSourceImpl(this.apiClient);


  @override
  Future<Result<List<SubjectModel>>> getAllSubjects() {
    return executeApi<List<SubjectModel>>(() async {
      final response = await apiClient.getAllSubjects();
      return response.subjects?.map((dto) => dto.toSubjectModels(),).toList()?? [];

    });
  }

  @override
  Future<Result<SubjectModel>> getSubjectById(String subjectId) {
    return executeApi<SubjectModel>(() async {
      final response = await apiClient.getSubjectById(subjectId);
      return response.category!.toSubjectModel();
    });
  }


  @override
  Future<Result<List<ExamModel>>> getAllExamsOnSubjects(String subjectId) {
    return executeApi<List<ExamModel>>(() async {
      final response = await apiClient.getAllExamsOnSubjects(subjectId);
      return response.exams?.map((dto) => dto.toExamModels(),).toList()?? [];

    });
  }

}