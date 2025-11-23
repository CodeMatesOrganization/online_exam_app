import 'package:flutter/material.dart';
import 'package:online_exam/core/theme/app_colors.dart';

class SubjectCard extends StatelessWidget {
  final String name;
  final String? icon; // رابط الصورة أو اسم الـ asset

  const SubjectCard({
    super.key,
    required this.name,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.gray.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          icon != null
              ? Image.network(
            icon!,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          )
              : SizedBox(
            width: 30,
            height: 30,
            child: Icon(Icons.book, color: AppColors.blue),
          ),
          const SizedBox(width: 10),
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
