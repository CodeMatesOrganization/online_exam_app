import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/ui/auth/login/LoginScreen.dart';
import 'package:online_exam/ui/auth/resetPassword/ResetPasswordScreen.dart';
import 'package:online_exam/ui/auth/verifyCode/VerifyViewModel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:online_exam/core/theme/app_colors.dart';

@injectable
class VerifyCode extends StatefulWidget {
  static const String routename = "/verify_code";


  const VerifyCode( {super.key});

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {

  late VerifyViewModel viewModel;


  @override
  void initState() {
    super.initState();

    viewModel = getIt<VerifyViewModel>();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Password Recovery",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Email Verification",
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Please enter your code that send to your email address ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.gray,
              ),
            ),
            SizedBox(height: 50),
            PinCodeTextField(
              appContext: context,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: MediaQuery.of(context).size.width * 0.12,
                activeFillColor: AppColors.white,
                inactiveFillColor: AppColors.babyBlue,
                selectedColor: AppColors.white,
                activeColor: AppColors.babyBlue,
                inactiveColor: AppColors.white,
              ),
              animationDuration: Duration(milliseconds: 12),
              enableActiveFill: true,
              onCompleted: (value) async {
                var isValid = await viewModel.verifyCode(value);

                if (isValid) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ResetPasswordScreen()),
                  );
                } else {
                  String errorMessage = "";
                  final currentState = viewModel.state;
                  if (currentState is VerifyErrorState) {
                    errorMessage = currentState.errorMessage;
                  } else {
                    errorMessage = "Something went wrong";
                  }

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Error"),
                      content: Text(errorMessage),
                    ),
                    useRootNavigator: true,
                  );
                }

              },
            ),
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: "Didn't Receive Code? ",
                children: [
                  TextSpan(
                    text: "Resend",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
