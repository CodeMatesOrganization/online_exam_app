import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/api/model/request/login_request.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/ui/auth/login/LoginContract.dart';
import 'package:online_exam/ui/auth/login/LoginViewModel.dart';
import 'package:online_exam/ui/widgets/CustomButton.dart';
import 'package:online_exam/ui/widgets/custome_text.dart';

class LoginScreen extends StatefulWidget {
  static const String routename = "Login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passController;

  late final LoginViewModel viewModel;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
    viewModel = getIt<LoginViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),

                  /// Email Field
                  CustomTextField(
                    hintText: "Enter Email",
                    isPassword: false,
                    labelText: "Email",
                    controller: emailController,
                    validator: (String? val) {
                      RegExp emailRegex = RegExp(
                          r"^[a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (val == null || val.trim().isEmpty) {
                        return 'this field is required';
                      } else if (!emailRegex.hasMatch(val)) {
                        return 'enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  /// Password Field
                  CustomTextField(
                    hintText: "Enter Password",
                    isPassword: true,
                    labelText: "Password",
                    controller: passController,
                    validator: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'this field is required';
                      } else if (val.length < 6) {
                        return 'password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  /// Remember me + Forget Password Row
                  BlocBuilder<LoginViewModel, LoginState>(
                    builder: (context, state) {
                      final loaded = state is LoginLoadedState
                          ? state
                          : viewModel.currentState;

                      return Row(
                        children: [
                          Checkbox(
                            value: loaded.rememberMe,
                            onChanged: (v) {
                              viewModel.doIntent(RememberMeToggled(v ?? false));
                            },
                          ),
                          const Text("Remember me"),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forget password?",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  /// Login Button
                  BlocBuilder<LoginViewModel, LoginState>(
                    builder: (context, state) {
                      return AppButton(
                        title: "Login",
                        isEnabled: true,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            viewModel.doIntent(LoginButtonClicked());
                            viewModel.authRepo.login(
                              LoginRequest(
                                email: emailController.text,
                                password: passController.text,
                              ),
                            );
                          }
                        },
                      );

                    },
                  ),

                  const SizedBox(height: 22),

                  /// Signup Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                          style: TextStyle(fontSize: 15)),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              color: Color(0xFF0056D6),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
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
