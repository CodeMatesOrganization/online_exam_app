import 'package:flutter/material.dart';
import 'package:online_exam/core/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final bool isPassword;
  final bool isSearch;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  CustomTextField({
    required this.hintText,
    required this.controller,
     this.labelText,
    this.validator,
    this.keyboardType,
    this.isSearch = false,
    this.isPassword = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: widget.isSearch ? const Icon(Icons.search) : null,
          prefixIconColor: AppColors.gray,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}
