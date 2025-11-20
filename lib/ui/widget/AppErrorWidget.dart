import 'package:flutter/material.dart';
import 'package:online_exam/domain/exceptions/custome_exception.dart';

class AppErrorWidget extends StatelessWidget {
  Exception? exception;
  VoidCallback? onRetry;
  AppErrorWidget({this.exception,this.onRetry,super.key,});

  @override
  Widget build(BuildContext context) {
    print("🔥 EXCEPTION TYPE: ${exception.runtimeType}");
    print("🔥 EXCEPTION DETAILS: $exception");

    String message ="";
    if(exception is ConnectionError){
      message = "No Internet Connection";
    }else if(exception is ServerError){
      var serverError = exception as ServerError;
      message = serverError.message;
    }else{
      message = "Something went wrong";
    }
    return Column(
        children:[
          Text(message),
          onRetry!=null?ElevatedButton(onPressed: (){
            onRetry?.call();
          }, child: Text("Retry")) : Container()
        ]
    );
  }
}