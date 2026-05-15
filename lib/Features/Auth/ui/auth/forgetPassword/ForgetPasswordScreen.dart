import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/Features/Auth/ui/auth/forgetPassword/ForgetPasswordContract.dart';
import 'package:online_exam/Features/Auth/ui/auth/forgetPassword/ForgetPasswordViewModel.dart';
import 'package:online_exam/Features/Auth/ui/auth/verifyCode/VerifyCode.dart';

import 'package:online_exam/Features/Auth/ui/widget/custome_text.dart';
import 'package:online_exam/Features/Auth/ui/widget/validator.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routename = "/forgetPassword";

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPasswordScreen> {
  late TextEditingController emailController;

  late final ForgetPasswordViewModel viewModel;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();

    viewModel = getIt<ForgetPasswordViewModel>();
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
                    "Forgot your password?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Enter your email associated with your account"),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: CustomTextField(
                        hintText: "Email",
                        labelText: "Email",
                        controller: emailController,
                        validator: emailValidator),
                  ),
                  BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
                      listener: (context, state) async {
                        if (state is ForgetPasswordLoadingState) {

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => Center(child: CircularProgressIndicator()),
                            useRootNavigator: true,
                          );
                        }
                        else if (state is ForgetPasswordErrorState) {

                          Navigator.of(context, rootNavigator: true).pop();
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("Error"),
                              content: Text(state.exception),
                            ),
                            useRootNavigator: true,
                          );
                        }
                        else if (state is ForgetPasswordSuccessState) {

                          Navigator.of(context, rootNavigator: true).pop(); // close loading
                          await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("Success"),
                              content: Text("OTP sent to your email!"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"),
                                )
                              ],
                            ),
                            useRootNavigator: true,
                          );

                          // navigation after success dialog
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => VerifyCode()),
                          );
                        }
                      },
                      builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            viewModel.doIntent(
                              ForgetPasswordButtonClicked(
                                  email: emailController.text.trim()),
                            );
                          }
                        },
                        child: Text("Continue"),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
