import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Subject/api/api_utils.dart';
import 'package:online_exam/Features/Subject/api/api_client.dart';
import 'package:online_exam/Features/Subject/data/dataSource/HomeOnlineDataSource.dart';
import 'package:online_exam/Features/Subject/domain/model/SubjectModel.dart';
import 'package:online_exam/Features/Subject/domain/result.dart';


@Injectable(as: HomeOnlineDataSource)
class HomeOnlineDataSourceImpl implements HomeOnlineDataSource {
  HomeApiClient apiClient;

  HomeOnlineDataSourceImpl(this.apiClient);


  @override
  Future<Result<List<SubjectModel>>> getAllSubjects() {
    return executeApi<List<SubjectModel>>(() async {
      final response = await apiClient.getAllSubjects();
      return response.subjects?.map((dto) => dto.toSubjectModels(),).toList()?? [];

    });
  }

}