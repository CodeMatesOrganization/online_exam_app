// import 'package:flutter/material.dart';
// import 'package:online_exam/di.dart';
// import 'package:online_exam/ui/auth/login/LoginViewModel.dart';
//
// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => getIt<LoginViewModel>(),
//       child: Consumer<LoginViewModel>(
//         builder: (context, viewModel, _) {
//           return Scaffold(
//             appBar: AppBar(title: const Text("Login")),
//             body: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextField(
//                     controller: emailController,
//                     decoration: const InputDecoration(labelText: "Email"),
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: const InputDecoration(labelText: "Password"),
//                   ),
//                   const SizedBox(height: 20),
//                   if (viewModel.isLoading)
//                     const CircularProgressIndicator()
//                   else
//                     ElevatedButton(
//                       onPressed: () {
//                         final email = emailController.text.trim();
//                         final password = passwordController.text.trim();
//                         viewModel.login(email, password);
//                       },
//                       child: const Text("Login"),
//                     ),
//                   if (viewModel.errorMessage != null) ...[
//                     const SizedBox(height: 16),
//                     Text(
//                       viewModel.errorMessage!,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ],
//                   if (viewModel.user != null) ...[
//                     const SizedBox(height: 16),
//                     Text(
//                       "Welcome, ${viewModel.user!.email}",
//                       style: const TextStyle(color: Colors.green),
//                     ),
//                   ]
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
