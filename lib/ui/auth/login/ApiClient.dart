abstract class ApiManager{
}

class DioApiManager extends ApiManager{}

class RetrofitApiManager extends ApiManager{
}

ApiManager? create(String type){

  if(type == "dio"){
    return DioApiManager();
  }else if(type == "retrofit"){
    return RetrofitApiManager();
  }
  return null;
}