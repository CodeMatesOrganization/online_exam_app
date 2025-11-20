import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  final String hintText;
  final String labelText;
  final bool isPassword;
  final TextInputType? keyboardType;

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  CustomTextField({
    required this.hintText,
    required this.controller,
    required this.labelText,
    this.validator,
    this.keyboardType,
    this.isPassword = false,


  });
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20 ),
        child: TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
          ),
        )

    );
  }

}