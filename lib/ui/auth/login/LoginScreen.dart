import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/theme/app_colors.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/ui/auth/login/LoginContract.dart';
import 'package:online_exam/ui/auth/login/LoginViewModel.dart';
import 'package:online_exam/ui/auth/signUp/SignUpScreen.dart';
import 'package:online_exam/ui/auth/signUp/SignUpViewModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.black,
        leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
        Navigator.pop(context);
        },)
      ),
      body: BlocConsumer<LoginViewModel, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Welcome ${state.user.firstName}!")),
            );
            // Navigator.pushReplacementNamed(context, '/home');
          } else if (state is LoginEmailError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          bool isLoading = state is LoginLoading;
          bool isEmailError = state is LoginEmailError;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: "Enter your email",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      errorText:
                      isEmailError ? "This email is not valid" : null,
                    ),
                    onChanged: (value) {
                      context.read<LoginViewModel>().add(EmailChanged(value));
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Password",
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Enter your password",
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() => rememberMe = value ?? false);
                        },
                      ),
                      const Text("Remember me"),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forget password?",
                          style: TextStyle(
                            color: AppColors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                      final intent = LoginButtonClicked(
                        emailController.text,
                        passwordController.text,
                      );
                      context.read<LoginViewModel>().add(intent);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLoading
                          ? AppColors.gray
                          : AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      "Login",
                      style: TextStyle(fontSize: 16 , color: AppColors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don’t have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => getIt<SignUpViewModel>(), // <== هنا الحل
                                child: const SignUpScreen(),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: AppColors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
