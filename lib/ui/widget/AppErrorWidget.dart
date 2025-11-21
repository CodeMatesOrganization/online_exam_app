import 'package:flutter/material.dart';
import 'package:online_exam/domain/exceptions/custome_exception.dart';

class AppErrorWidget extends StatelessWidget {
  Exception? exception;
  String? message;
  VoidCallback? onRetry;
  AppErrorWidget({this.exception,this.onRetry, this.message ,super.key,});

  @override
  Widget build(BuildContext context) {
    print("🔥 EXCEPTION MESSAGE : ${message}");

    print("🔥 EXCEPTION TYPE: ${exception.runtimeType}");
    print("🔥 EXCEPTION DETAILS: $exception");

    String result ="";
    if(exception is ConnectionError){
      result = "No Internet Connection";
    }else if(exception is ServerError){
      var serverError = exception as ServerError;
      result = serverError.message;
    }else{
      result = "Something went wrong";
    }
    return Column(
        children:[
          Text(message ?? result,
            style: TextStyle(fontSize: 16, color: Colors.red), textAlign: TextAlign.center,),
          onRetry!=null?ElevatedButton(onPressed: (){
            onRetry?.call();
          }, child: Text("Retry")) : Container()
        ]
    );
  }
}