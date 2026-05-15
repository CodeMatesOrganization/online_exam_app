import 'package:flutter/material.dart';
import 'package:online_exam/core/theme/app_colors.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Text('Password' , style: TextStyle(color: AppColors.gray),),
              SizedBox(width: 10),
              Text('******', style: TextStyle(color: AppColors.gray)),
            ],
          ),
          TextButton(
            onPressed: () {
              print('Change password pressed');
            },
            child: const Text(
              'Change',
              style: TextStyle(color: AppColors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
