
import 'package:online_exam/domain/result.dart';

Future<Result<T>> executeApi<T> (Future<T> apiCall())async{

  try{
    var result = await apiCall.call();
    return Success(result);

  }on Exception catch(ex){
    return Failure(ex);
  }
}