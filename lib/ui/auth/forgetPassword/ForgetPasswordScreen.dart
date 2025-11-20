import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/ui/auth/forgetPassword/ForgetPasswordContract.dart';
import 'package:online_exam/ui/auth/forgetPassword/ForgetPasswordViewModel.dart';
import 'package:online_exam/ui/auth/login/LoginScreen.dart';
import 'package:online_exam/ui/widget/AppErrorWidget.dart';
import 'package:online_exam/ui/widget/custome_text.dart';
import 'package:online_exam/ui/widget/validator.dart';

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
                    listener: (context, state) {
                      if (state is ForgetPasswordLoadingState) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        // أغلق dialog لو مفتوح
                        if (Navigator.canPop(context)) Navigator.pop(context);

                        if (state is ForgetPasswordErrorState) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Error"),
                              content: AppErrorWidget(
                                exception: state.exception,
                                onRetry: () {
                                  if (Navigator.canPop(context)) Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        } else if (state is ForgetPasswordSuccessState) {
                          if (formKey.currentState!.validate()) {
                            // تنفيذ navigation بعد انتهاء frame الحالي
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              viewModel.doIntent(NavigateToResetPassword());
                            });
                          }
                        } else if (state is NavigateToResetPasswordEvent) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (Navigator.canPop(context)) Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                            );
                          });
                        }
                      }
                    },

                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            viewModel.doIntent(NavigateToResetPassword());
                          }
                        },
                        child: Text("Continue"),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
