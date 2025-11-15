import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  final String hintText;
  final String lableText;
  final bool isPassword;



  final TextEditingController? controller;
  final String? Function(String?)? validator;
  CustomTextField({
    required this.hintText,
    required this.isPassword,
    required this.controller,
    this.validator,
    required this.lableText

  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20 ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isPassword,
        decoration: InputDecoration(

          labelText: lableText,
          hintText: hintText,
        ),
      )

    );
  }

}