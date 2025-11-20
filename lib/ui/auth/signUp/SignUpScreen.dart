import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/theme/app_colors.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/ui/auth/login/LoginScreen.dart';
import 'package:online_exam/ui/auth/signUp/SignUpContract.dart';
import 'package:online_exam/ui/auth/signUp/SignUpViewModel.dart';
import 'package:online_exam/ui/auth/signUp/widget/validator.dart';
import 'package:online_exam/ui/widget/AppErrorWidget.dart';
import 'package:online_exam/ui/widget/custome_text.dart';

class SignUpScreen extends StatefulWidget {
  static const String routename = "SignUp";

  @override
  State<SignUpScreen> createState() => _SignupState();
}

class _SignupState extends State<SignUpScreen> {
  late TextEditingController usercontroller;

  late TextEditingController firstcontroller;

  late TextEditingController secondcontroller;

  late TextEditingController emailcontroller;

  late TextEditingController passcontroller;

  late TextEditingController confirmcontroller;

  late TextEditingController phonecontroller;

  late final SignUpViewModel viewModel;
  void initState() {
    super.initState();
    usercontroller = TextEditingController();
    firstcontroller = TextEditingController();
    secondcontroller = TextEditingController();
    emailcontroller = TextEditingController();
    phonecontroller = TextEditingController();
    passcontroller = TextEditingController();
    confirmcontroller = TextEditingController();
    viewModel = getIt<SignUpViewModel>();
  }

  @override
  void dispose() {
    super.dispose();
    usercontroller.dispose();
    firstcontroller.dispose();
    secondcontroller.dispose();
    emailcontroller.dispose();
    phonecontroller.dispose();
    passcontroller.dispose();
    confirmcontroller.dispose();
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
                    controller: usercontroller,
                    validator: nulltyChecker,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          hintText: "First Name",
                          labelText: "First Name",
                          controller: firstcontroller,
                          validator: nulltyChecker),
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: "Enter Second Name",
                        isPassword: false,
                        labelText: "Second Name",
                        controller: secondcontroller,
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
                      controller: emailcontroller,
                      validator: emailValidator),
                ),
                Row(children: [
                  Expanded(
                    child: CustomTextField(
                        hintText: "Password",
                        isPassword: true,
                        labelText: "Password",
                        controller: passcontroller,
                        validator: passwordValidator),
                  ),
                  Expanded(
                    child: CustomTextField(
                        hintText: "Confirm Password",
                        isPassword: true,
                        labelText: "Confirm Password",
                        controller: confirmcontroller,
                        validator: (val) => confirmPasswordValidator(
                            val,
                            passcontroller.text
                        )),
                  ),
                ]),
                Container(
                  width: double.infinity,
                  child: CustomTextField(
                      keyboardType: TextInputType.phone,
                      hintText: "phone number",
                      labelText: "Phone Number",
                      controller: phonecontroller,
                      validator: phoneValidator
                  ),
                ),

                BlocConsumer<SignUpViewModel, SignUpState>(
                  listener: (context, state) async {
                    // 1. Loading
                    if (state is SignUpLoadingState) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => Center(child: CircularProgressIndicator()),
                      );
                    }
                    // 2. Error
                    else if (state is SignUpErrorState) {
                      Navigator.of(context, rootNavigator: true).pop();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: AppErrorWidget(
                            exception: state.exception,
                            onRetry: () => Navigator.pop(context),
                          ),
                        ),
                      );
                    }
                    // 3. Success
                    else if (state is SignUpSuccessState) {
                      Navigator.of(context, rootNavigator: true).pop(); // أغلق loading
                      await showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Success"),
                          content: Text("Sign Up Successful! Please Login."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                     viewModel.doIntent(NavigateToLogin());
                    }
                    // 4. Navigate directly
                    else if (state is NavigateToLoginEvent) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          viewModel.doIntent(SignUpButtonClicked(
                            userName: usercontroller.text.trim(),
                            firstName: firstcontroller.text.trim(),
                            lastName: secondcontroller.text.trim(),
                            email: emailcontroller.text.trim(),
                            password: passcontroller.text,
                            confirmPassword: confirmcontroller.text,
                            phone: phonecontroller.text.trim(),
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
                            print("Button clicked");

                            viewModel.doIntent(NavigateToLogin());
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.w900),
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