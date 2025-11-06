import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/ui/auth/login/LoginScreen.dart';
import 'package:online_exam/ui/auth/login/LoginViewModel.dart';
import 'di.dart';
import 'package:get_it/get_it.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<LoginViewModel>(),
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
