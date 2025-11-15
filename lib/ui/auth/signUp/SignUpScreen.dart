import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/api/model/request/sign_up_request.dart';
import 'package:online_exam/core/theme/app_colors.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/ui/auth/login/LoginScreen.dart';
import 'package:online_exam/ui/auth/signUp/SignUpContract.dart';
import 'package:online_exam/ui/auth/signUp/SignUpViewModel.dart';
import 'package:online_exam/ui/auth/signUp/widget/validator.dart';
import 'package:online_exam/ui/widget/AppErrorWidget.dart';
import 'package:online_exam/ui/widget/LoadingWidget.dart';
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
                  listener: (context, state) {
                    if (state is SignUpLoadingState) {
                      LoadingWidget;
                    } else if (state is SignUpErrorState) {
                     AppErrorWidget(exception: state.exception);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          viewModel.authRepo.signUp(
                            SignUpRequest(
                              firstName: firstcontroller.text,
                              lastName: secondcontroller.text,
                              rePassword: confirmcontroller.text,
                              username: usercontroller.text,
                              email: emailcontroller.text,
                              password: passcontroller.text,
                              phone: phonecontroller.text,
                            ),
                          );
                        }
                      },
                      child: Text("SignUp",),
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
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