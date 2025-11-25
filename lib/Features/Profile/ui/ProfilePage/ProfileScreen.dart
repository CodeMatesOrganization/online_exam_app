import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/Features/Profile/ui/ProfilePage/ProfileContract.dart';
import 'package:online_exam/Features/Profile/ui/ProfilePage/ProfileViewModel.dart';
import 'package:online_exam/Features/Profile/ui/ProfilePage/widgets/custom_field.dart';
import 'package:online_exam/core/theme/app_colors.dart';
import 'package:online_exam/di.dart';
import 'package:online_exam/Features/Auth/ui/auth/login/LoginScreen.dart';
import 'package:online_exam/Features/Auth/ui/widget/validator.dart';
import 'package:online_exam/Features/Auth/ui/widget/AppErrorWidget.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController userController;

  late TextEditingController firstController;

  late TextEditingController secondController;

  late TextEditingController emailController;

  late TextEditingController passController;


  late TextEditingController phoneController;

  late final ProfileViewModel viewModel;

  @override

  void initState() {
    super.initState();
    userController = TextEditingController();
    firstController = TextEditingController();
    secondController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passController = TextEditingController();
    viewModel = getIt<ProfileViewModel>();

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
  }


  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: false,
           title: Text(
              "Profile",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )),
        body: BlocConsumer<ProfileViewModel, ProfileState>(
          listener: (context, state) async {
            if (state is ProfileLoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => Center(child: CircularProgressIndicator()),
              );
            }
            else if (state is ProfileErrorState) {
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
            else if (state is UpdateProfile) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileSuccessState) {
              final user = state.user;
              return  SingleChildScrollView(
                  child: Form(
                      key: formKey,
                      child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: CustomField(
                                hintText: user.username ?? "",
                                labelText: "UserName",
                                controller: userController,
                                validator: nulltyChecker,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomField(
                                      hintText: user.firstName ?? "",
                                      labelText: "First Name",
                                      controller: firstController,
                                      validator: nulltyChecker),
                                ),
                                Expanded(
                                  child: CustomField(
                                    hintText: user.lastName ?? "",
                                    labelText: "Last Name",
                                    controller: secondController,
                                    validator: nulltyChecker,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: CustomField(
                                  hintText: user.email ?? "",
                                  labelText: "Email",
                                  controller: emailController,
                                  validator: emailValidator),
                            ),
                            Container(
                              width: double.infinity,
                              child: CustomField(
                                  hintText: "*****",
                                  isRead: true,
                                  labelText: "Password",
                                  controller: passController,
                                  validator: passwordValidator),
                            ),

                            Container(
                              width: double.infinity,
                              child: CustomField(
                                  keyboardType: TextInputType.phone,
                                  hintText: user.phone ?? "",
                                  labelText: "Phone Number",
                                  controller: phoneController,
                                  validator: phoneValidator
                              ),
                            ),
                            SizedBox(height: 20,),

                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {

                                }
                              },
                              child: Text("Update"),
                            ),
                            SizedBox(height: 20,),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                }
                              },
                              child: Text("Log out"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.red
                              ),
                            )
                          ])
                  )
              );
            }
            return Container();
          },
                ),
            ),
          );
  }

}