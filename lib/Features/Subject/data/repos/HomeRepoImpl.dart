import 'package:injectable/injectable.dart';
import 'package:online_exam/Features/Subject/data/dataSource/HomeOnlineDataSource.dart';
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

}