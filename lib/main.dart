import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/theme/app_theme.dart';
import 'package:online_exam/ui/auth/login/LoginScreen.dart';
import 'package:online_exam/ui/auth/login/LoginViewModel.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginViewModel>(
          create: (_) => GetIt.instance<LoginViewModel>(),
        ),
        BlocProvider<SignUpViewModel>(
          create: (_) => GetIt.instance<SignUpViewModel>(),
        ),
        // لو عندك ViewModels تانية ممكن تضيفيها هنا
      ],
      child: MaterialApp(
        theme: AppTheme.generalTheme,
        initialRoute: SignUpScreen.routename,
        routes: {
          LoginScreen.routename: (_) => LoginScreen(),
          SignUpScreen.routename: (_) => SignUpScreen(),
          // ممكن تضيفي أي شاشة تانية هنا
        },
      ),
    );
  }
}
