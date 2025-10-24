import 'package:flutter/material.dart';
import 'package:online_exam/ui/auth/signUp/SignUpViewModel.dart';
import 'package:provider/provider.dart';
import 'package:online_exam/di.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<SignUpViewModel>(),
      child: Consumer<SignUpViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Sign up"),
              centerTitle: true,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildField("User name", usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This username is not valid";
                          }
                          return null;
                        }),
                    Row(
                      children: [
                        Expanded(
                          child: _buildField("First name", firstNameController),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildField("Last name", lastNameController),
                        ),
                      ],
                    ),
                    _buildField("Email", emailController, validator: (value) {
                      if (value == null ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                        return "This Email is not valid";
                      }
                      return null;
                    }),
                    _buildField("Password", passwordController,
                        obscure: true),
                    _buildField("Confirm password", confirmPasswordController,
                        obscure: true, validator: (value) {
                          if (value != passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        }),
                    _buildField("Phone number", phoneController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: viewModel.isLoading
                            ? Colors.grey
                            : const Color(0xFF02369C),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: viewModel.isLoading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          viewModel.signUp(
                            username: usernameController.text.trim(),
                            firstName: firstNameController.text.trim(),
                            lastName: lastNameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            rePassword:
                            confirmPasswordController.text.trim(),
                            phone: phoneController.text.trim(),
                          );
                        }
                      },
                      child: viewModel.isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Text("Signup",
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.black87),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: TextStyle(color: Color(0xFF02369C)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (viewModel.errorMessage != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        viewModel.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {bool obscure = false, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
