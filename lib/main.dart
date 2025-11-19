import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/theme/app_theme.dart';
import 'package:online_exam/ui/auth/forgetPassword/ForgetPasswordScreen.dart';
import 'package:online_exam/ui/auth/signUp/SignUpScreen.dart';
import 'package:online_exam/ui/auth/signUp/SignUpViewModel.dart';
import 'package:online_exam/ui/common/bloc_observer.dart';
import 'di.dart';
import 'package:get_it/get_it.dart';

void main() {
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<SignUpViewModel>(),
      child: MaterialApp(
        theme: AppTheme.generalTheme,
        initialRoute: '/forget_password', // الشاشة اللي تظهر أولاً
        routes: {
          '/forget_password': (context) => ForgetPasswordScreen(),
          '/sign_up': (context) => SignUpScreen(),
        },
      ),
    );
  }
}

