import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/Features/Subject/ui/HomeScreen.dart';
import 'package:online_exam/core/theme/app_colors.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/Features/Auth/ui/auth/forgetPassword/ForgetPasswordScreen.dart';
import 'package:online_exam/Features/Auth/ui/auth/login/LoginContract.dart';
import 'package:online_exam/Features/Auth/ui/auth/login/LoginViewModel.dart';
import 'package:online_exam/Features/Auth/ui/auth/signUp/SignUpScreen.dart';
import 'package:online_exam/Features/Auth/ui/widget/validator.dart';
import 'package:online_exam/Features/Auth/ui/widget/AppErrorWidget.dart';
import 'package:online_exam/Features/Auth/ui/widget/custome_text.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passController;
  late final LoginViewModel viewModel;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
    viewModel = getIt<LoginViewModel>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Login",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: "Enter Email",
                    labelText: "Email",
                    controller: emailController,
                    validator: emailValidator,
                  ),
                  const SizedBox(height: 18),
                  CustomTextField(
                    hintText: "Enter Password",
                    isPassword: true,
                    labelText: "Password",
                    controller: passController,
                    validator: passwordValidator,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (_) {}),
                      const Text("Remember me"),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          viewModel.doIntent(ForgetPasswordButtonClicked());
                        },
                        child: const Text(
                          "Forget password?",
                          style: TextStyle(color: AppColors.gray, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  BlocConsumer<LoginViewModel, LoginState>(
                    listener: (context, state) async {
                      if (state is LoginLoadingState) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.blue,
                            ),
                          ),
                        );
                      } else if (state is LoginErrorState) {
                        Navigator.of(context, rootNavigator: true).pop();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Error"),
                            content: AppErrorWidget(
                              exception: state.exception,
                              onRetry: () => Navigator.pop(context),
                            ),
                          ),
                        );
                      } else if (state is LoginSuccessState) {
                        Navigator.of(context, rootNavigator: true).pop();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => HomeScreen()),
                        );
                      } else if (state is NavigateToForgotPasswordEvent) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ForgetPasswordScreen(),
                          ),
                        );
                      } else if (state is NavigateToSignUpEvent) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            viewModel.doIntent(
                              LoginButtonClicked(
                                email: emailController.text.trim(),
                                password: passController.text.trim(),
                              ),
                            );
                          }
                        },
                        child: const Text("Login"),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          viewModel.doIntent(SignUpClicked());
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: AppColors.blue,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
