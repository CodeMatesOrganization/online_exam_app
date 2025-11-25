import 'package:flutter/material.dart';
import 'package:online_exam/core/theme/app_colors.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final bool isRead;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  CustomField({
    required this.hintText,
    required this.controller,
     this.labelText,
    this.validator,
    this.keyboardType,
    this.isRead = false,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintStyle: TextStyle(color: AppColors.black , fontWeight: FontWeight.w500),
          hintText: hintText,

        ),
      ),
    );

  }
  }

