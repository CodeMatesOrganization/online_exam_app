import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/Features/Auth/ui/auth/resetPassword/ResetPasswordContract.dart';
import 'package:online_exam/Features/Auth/ui/auth/resetPassword/ResetPasswordViewModel.dart';
import 'package:online_exam/Features/Auth/ui/auth/login/LoginScreen.dart';
import 'package:online_exam/Features/Auth/ui/widget/custome_text.dart';
import 'package:online_exam/Features/Auth/ui/widget/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routename = "/resetPassword";

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordScreen> {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  late final ResetPasswordViewModel viewModel;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    passwordController = TextEditingController();

    confirmPasswordController = TextEditingController();
    viewModel = getIt<ResetPasswordViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => viewModel,
        child: Scaffold(
          appBar: AppBar(
              centerTitle: false,
              leading: IconButton(
                  onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
              title: Text(
                "Password Recovery",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              )),
          body: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "Reset password?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Password must not be empty and must contain 6 characters with upper case letter and one number at least ",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: CustomTextField(
                      isPassword: true,
                        hintText: "Enter your password",
                        labelText: "New Password",
                        controller: passwordController,
                        validator: passwordValidator),
                  ),
                  Container(
                    width: double.infinity,
                    child: CustomTextField(
                      isPassword: true,
                        hintText: "Confirm password",
                        labelText: "Confirm Password",
                        controller: confirmPasswordController,
                        validator: (val) => confirmPasswordValidator(val, passwordController.text.trim())),
                  ),
                  BlocConsumer<ResetPasswordViewModel, ResetPasswordState>(
                    listener: (context, state) {
                      if (state is ResetPasswordLoadingState) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) =>
                              Center(child: CircularProgressIndicator()),
                          useRootNavigator: true,
                        );
                      } else if (state is ResetPasswordErrorState) {
                        Navigator.of(context, rootNavigator: true)
                            .pop(); // close loading

                        Navigator.of(context, rootNavigator: true).pop();
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Error"),
                            content: Text(state.exception.toString()),
                          ),
                          useRootNavigator: true,
                        );
                      } else if (state is ResetPasswordSuccessState) {
                        Navigator.of(context, rootNavigator: true)
                            .pop(); // close loading
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Success"),
                            content: Text("Changed password successful"),
                            actions: [
                              TextButton(
                                onPressed: (){
                                  Navigator.pop(context); // close success dialog
                                  viewModel.doIntent(NavigateToLogin()); // بعد الضغط نروح Login
                                },
                                child: Text("OK"),
                              )
                            ],
                          ),
                          useRootNavigator: true,
                        );
                      } else if (state is NavigateToLoginEvent) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (Navigator.canPop(context)) Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        });
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () async{
                          if (formKey.currentState!.validate()) {
                            final email = await getSavedEmail();
                            if (email == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Please request a reset code first.")),
                              );
                              return;
                            }
                            viewModel.doIntent(
                              ResetPasswordButtonClicked(
                                email: email,
                                newPassword: passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                        child: Text("Continue"),
                      )
                      ;
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  Future<String?> getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('reset_email');
  }

}
