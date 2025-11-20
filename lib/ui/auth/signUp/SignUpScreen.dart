import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/theme/app_colors.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/ui/auth/login/LoginScreen.dart';
import 'package:online_exam/ui/auth/signUp/SignUpContract.dart';
import 'package:online_exam/ui/auth/signUp/SignUpViewModel.dart';
import 'package:online_exam/ui/widget/validator.dart';
import 'package:online_exam/ui/widget/AppErrorWidget.dart';
import 'package:online_exam/ui/widget/custome_text.dart';

class SignUpScreen extends StatefulWidget {
  static const String routename = "SignUp";

  @override
  State<SignUpScreen> createState() => _SignupState();
}

class _SignupState extends State<SignUpScreen> {
  late TextEditingController userController;

  late TextEditingController firstController;

  late TextEditingController secondController;

  late TextEditingController emailController;

  late TextEditingController passController;

  late TextEditingController confirmController;

  late TextEditingController phoneController;

  late final SignUpViewModel viewModel;
  void initState() {
    super.initState();
    userController = TextEditingController();
    firstController = TextEditingController();
    secondController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passController = TextEditingController();
    confirmController = TextEditingController();
    viewModel = getIt<SignUpViewModel>();
  }

  @override
  void dispose() {
    super.dispose();
    userController.dispose();
    firstController.dispose();
    secondController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passController.dispose();
    confirmController.dispose();
  }


  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: false,
            leading:
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
            title: Text(
              "Sign Up",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: CustomTextField(
                    hintText: "Enter your user name",
                    labelText: "UserName",
                    controller: userController,
                    validator: nulltyChecker,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          hintText: "First Name",
                          labelText: "First Name",
                          controller: firstController,
                          validator: nulltyChecker),
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: "Enter Second Name",
                        isPassword: false,
                        labelText: "Second Name",
                        controller: secondController,
                        validator: nulltyChecker,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: CustomTextField(
                      hintText: "Email",
                      labelText: "Email",
                      controller: emailController,
                      validator: emailValidator),
                ),
                Row(children: [
                  Expanded(
                    child: CustomTextField(
                        hintText: "Password",
                        isPassword: true,
                        labelText: "Password",
                        controller: passController,
                        validator: passwordValidator),
                  ),
                  Expanded(
                    child: CustomTextField(
                        hintText: "Confirm Password",
                        isPassword: true,
                        labelText: "Confirm Password",
                        controller: confirmController,
                        validator: (val) => confirmPasswordValidator(
                            val,
                            passController.text
                        )),
                  ),
                ]),
                Container(
                  width: double.infinity,
                  child: CustomTextField(
                    keyboardType: TextInputType.phone,
                      hintText: "phone number",
                      labelText: "Phone Number",
                      controller: phoneController,
                      validator: phoneValidator
                      ),
                ),

                BlocConsumer<SignUpViewModel, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpLoadingState) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      Navigator.of(context).pop(); // يقفل الـ loading
                      if (state is SignUpErrorState) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Error"),
                            content: AppErrorWidget(
                              exception: state.exception,
                              onRetry: () {
                                Navigator.pop(context); // يغلق الديالوج
                                // ممكن تعيد محاولة التسجيل أو أي حاجة مناسبة
                              },
                            ),
                          ),
                        );
                      } else if (state is SignUpSuccessState) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Success"),
                            content: Text("Sign Up Successful! Please Login."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  viewModel.doIntent(NavigateToLogin());
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }else if (state is NavigateToLoginEvent) {
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                    }
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          viewModel.doIntent(SignUpButtonClicked(
                            userName: userController.text.trim(),
                            firstName: firstController.text.trim(),
                            lastName: secondController.text.trim(),
                            email: emailController.text.trim(),
                            password: passController.text,
                            confirmPassword: confirmController.text,
                            phone: phoneController.text.trim(),
                          ));
                        }

                      },
                      child: Text("Sign Up"),
                    );
                  },
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 20 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ?",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            viewModel.doIntent(NavigateToLogin());
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}