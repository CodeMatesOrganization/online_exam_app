import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/Features/Auth/ui/auth/forgetPassword/ForgetPasswordScreen.dart';
import 'package:online_exam/Features/Auth/ui/auth/login/LoginScreen.dart';
import 'package:online_exam/Features/Auth/ui/auth/resetPassword/ResetPasswordScreen.dart';
import 'package:online_exam/Features/Auth/ui/auth/signUp/SignUpScreen.dart';
import 'package:online_exam/Features/Auth/ui/auth/signUp/SignUpViewModel.dart';
import 'package:online_exam/Features/Auth/ui/auth/verifyCode/VerifyCode.dart';
import 'package:online_exam/Features/Auth/ui/auth/verifyCode/VerifyViewModel.dart';
import 'package:online_exam/Features/Profile/ui/ProfilePage/ProfileScreen.dart';
import 'package:online_exam/Features/Subject/ui/Exams/ExamsScreen.dart';
import 'package:online_exam/Features/Subject/ui/HomeScreen.dart';
import 'package:online_exam/Features/Subject/ui/Subjects/SubjectScreen.dart';
import 'package:online_exam/Features/Questions/ui/questions/QuestionsScreen.dart';
import 'package:online_exam/core/local/Prefrence.dart';
import 'package:online_exam/core/theme/app_theme.dart';
import 'di.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
    WidgetsFlutterBinding.ensureInitialized();
    await PrefsHelper.init();
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return ScreenUtilInit(
        designSize:
        const Size(390, 844), // حجم الشاشة التصميمية (iPhone 13 مثلاً)
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: AppTheme.generalTheme,
            initialRoute: '/login',
            routes: {
              '/forget_password': (context) => ForgetPasswordScreen(),
              '/sign_up': (context) =>
                  BlocProvider(
                    create: (_) => GetIt.instance<SignUpViewModel>(),
                    child: SignUpScreen(),
                  ),
              '/login': (context) => LoginScreen(),
              '/verify_code': (context) =>
                  BlocProvider(
                    create: (_) => GetIt.instance<VerifyViewModel>(),
                    child: VerifyCode(),
                  ),
              '/reset_password': (context) => ResetPasswordScreen(),
              '/home_subject': (context) => SubjectScreen(),
              '/home': (context) => HomeScreen(),
              '/exam': (context) => ExamsScreen(),
              '/questions': (context) =>
                  QuestionsScreen(examId: "670070a830a3c3c1944a9c63"),
              '/profile': (context) => ProfileScreen(),

            },
          );
        },
      );
    }
  }