import 'package:flutter/material.dart';
import 'package:online_exam/core/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.title,
    required this.isEnabled,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ?  AppColors.blue :  AppColors.gray,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
