import 'package:flutter/material.dart';
import 'package:online_exam/Features/Profile/domain/model/UserModel.dart';
import 'package:online_exam/Features/Profile/ui/ProfilePage/ProfileContract.dart';
import 'package:online_exam/Features/Profile/ui/ProfilePage/ProfileViewModel.dart';
import 'package:online_exam/Features/Profile/ui/ProfilePage/widgets/custom_field.dart';
import 'package:online_exam/Features/Profile/ui/ProfilePage/widgets/password_field.dart';
import 'package:online_exam/core/theme/app_colors.dart' ;

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    super.key,
    required this.formKey,
    required this.user,
    required this.viewModel
  });

  final GlobalKey<FormState> formKey;
  final UserModel user;
  final ProfileViewModel viewModel;


  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late TextEditingController userController;
  late TextEditingController firstController;
  late TextEditingController secondController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passController;

  @override
  void initState() {
    super.initState();

    userController = TextEditingController(text: widget.user.userName ?? "");
    firstController = TextEditingController(text: widget.user.firstName ?? "");
    secondController = TextEditingController(text: widget.user.lastName ?? "");
    emailController = TextEditingController(text: widget.user.email ?? "");
    phoneController = TextEditingController(text: widget.user.phone ?? "");
    passController = TextEditingController(text: "*****");
  }

  @override
  void dispose() {
    userController.dispose();
    firstController.dispose();
    secondController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            CustomField(
              hintText: widget.user.userName ?? "",
              labelText: "UserName",
              controller: userController,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomField(
                    hintText: widget.user.firstName ?? "",
                    labelText: "First Name",
                    controller: firstController,
                  ),
                ),
                Expanded(
                  child: CustomField(
                    hintText: widget.user.lastName ?? "",
                    labelText: "Last Name",
                    controller: secondController,
                  ),
                ),
              ],
            ),
            CustomField(
              hintText: widget.user.email ?? "",
              labelText: "Email",
              controller: emailController,
              isEmail: true,
            ),
           PasswordField(),
            CustomField(
              keyboardType: TextInputType.phone,
              hintText: widget.user.phone ?? "",
              labelText: "Phone Number",
              controller: phoneController,
              isPhone: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.formKey.currentState!.validate()) {
                  widget.viewModel.doIntent(
                    UpdateProfileIntent(
                      userName: userController.text.trim(),
                      firstName: firstController.text.trim(),
                      lastName: secondController.text.trim(),
                      email: emailController.text.trim(),
                      phone: phoneController.text.trim(),
                    ),
                  );
                }
              },
              child: Text("Update"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.viewModel.doIntent(LogOutIntent());
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
              child: Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }
}
