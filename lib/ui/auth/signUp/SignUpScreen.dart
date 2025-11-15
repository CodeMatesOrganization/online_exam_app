import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/api/model/request/sign_up_request.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/ui/auth/login/LoginScreen.dart';
import 'package:online_exam/ui/auth/signUp/SignUpContract.dart';
import 'package:online_exam/ui/auth/signUp/SignUpViewModel.dart';
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
                    hintText: "Enter Username",
                    isPassword: false,
                    lableText: "UserName",
                    controller: usercontroller,
                    validator: (String? val) {
                      //RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');
                      if (val == null) {
                        return 'this field is required';
                      } else if (val.isEmpty) {
                        return 'this field is required';
                      } //else if (!usernameRegex.hasMatch(val)) {
                      // return 'enter valid username';}
                      else {
                        return val.isEmpty ? "username can't be empty" : " ";
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          hintText: "First Name",
                          isPassword: false,
                          lableText: "First Name",
                          controller: firstcontroller,
                          validator: (String? val) {
                            if (val == null || val.isEmpty) {
                              return 'this field is required';
                            } else {
                              return null;
                            }
                          }),
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: "Enter Second Name",
                        isPassword: false,
                        lableText: "Second Name",
                        controller: secondcontroller,
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'this field is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: CustomTextField(
                      hintText: "Email",
                      isPassword: false,
                      lableText: "Email",
                      controller: emailcontroller,
                      validator: (String? val) {
                        RegExp emailRegex = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (val == null) {
                          return 'this field is required';
                        } else if (val.trim().isEmpty) {
                          return 'this field is required';
                        } else if (emailRegex.hasMatch(val) == false) {
                          return 'enter valid email';
                        } else {
                          return val.isEmpty ? "Email can't be empty" : null;
                        }
                      }),
                ),
                Row(children: [
                  Expanded(
                    child: CustomTextField(
                        hintText: "Password",
                        isPassword: true,
                        lableText: "Password",
                        controller: passcontroller,
                        validator: (String? val) {
                          RegExp passwordRegex =
                          RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])');
                          if (val == null) {
                            return 'this field is required';
                          } else if (val.isEmpty) {
                            return 'this field is required';
                          } else if (val.length < 8 ||
                              !passwordRegex.hasMatch(val)) {
                            return 'strong password please';
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Expanded(
                    child: CustomTextField(
                        hintText: "Confirm Password",
                        isPassword: true,
                        lableText: "Confirm Password",
                        controller: confirmcontroller,
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'this field is required';
                          } else {
                            return null;
                          }
                        }),
                  ),
                ]),
                Container(
                  width: double.infinity,
                  child: CustomTextField(
                      hintText: "phone number",
                      isPassword: false,
                      lableText: "Phone Number",
                      controller: phonecontroller,
                      validator: (String? val) {
                        if (val == null) {
                          return 'this field is required';
                        } else if (int.tryParse(val.trim()) == null) {
                          return 'enter numbers only';
                        } else if (val.trim().length != 11) {
                          return 'enter value must equal 11 digit';
                        } else {
                          return null;
                        }
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                BlocConsumer<SignUpViewModel, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpLoadingState) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.black),
                            ),
                          ));
                    } else if (state is SignUpErrorState) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(state.exception.toString()),
                                ],
                              ),
                            ),
                          ));
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          print("Form is valid");
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
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
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}