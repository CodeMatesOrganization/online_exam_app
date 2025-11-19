import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/ui/auth/signUp/SignUpContract.dart';
import 'package:online_exam/ui/auth/signUp/SignUpViewModel.dart';
import 'package:online_exam/ui/auth/signUp/widget/validator.dart';
import 'package:online_exam/ui/widget/AppErrorWidget.dart';
import 'package:online_exam/ui/widget/custome_text.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routename = "SignUp";

  @override
  State<ForgetPasswordScreen> createState() => _SignupState();
}

class _SignupState extends State<ForgetPasswordScreen> {


  late TextEditingController emailcontroller;


  late final SignUpViewModel viewModel;
  void initState() {
    super.initState();

    emailcontroller = TextEditingController();

    viewModel = getIt<SignUpViewModel>();
  }


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
              "Password Recovery",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )),
        body:
          Center(
            child: Column(
              children: [
                Text("Forgot your password?" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                Text("Enter your email associated with your account"),
                SizedBox(height: 30,),
                Container(
                  width: double.infinity,
                  child: CustomTextField(
                      hintText: "Email",
                      labelText: "Email",
                      controller: emailcontroller,
                      validator: emailValidator),
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
                                Navigator.pop(context);
                                },
                            ),
                          ),
                        );
                      } else if (state is SignUpSuccessState) {

                      }
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {

                      },
                      child: Text("Continue"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }

}