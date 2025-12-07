import 'package:flutter/material.dart';
import 'package:online_exam/core/theme/app_colors.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final bool isRead;
  final bool? isEmail;
  final bool? isPhone;
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
    this.isEmail = false,
    this.isPhone = false
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        readOnly: isRead,
        validator: (value) {
          if (validator != null) {
            final custom = validator!(value);
            if (custom != null) return custom;
          }

          if (isEmail == true && value != null && value.isNotEmpty) {
            return emailValidator(value);
          }

          if (isPhone == true && value != null && value.isNotEmpty) {
            return phoneValidator(value);
          }

          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
          hintStyle: TextStyle(
              color: AppColors.black, fontWeight: FontWeight.w500),
          hintText: hintText,

        ),
      ),
    );
  }

  String? emailValidator(String val) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (emailRegex.hasMatch(val) == false) {
      return 'enter valid email';
    }
    return null;
  }


  String? phoneValidator(String val) {
    RegExp phoneRegex = RegExp(r'^\+?[0-9]{11}$');


    if (!phoneRegex.hasMatch(val.trim())) {
      return 'enter valid phone number';
    } else {
      return null;
    }
  }
}
