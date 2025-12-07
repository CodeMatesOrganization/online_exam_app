import 'package:flutter/material.dart';
import 'package:online_exam/core/app_assets.dart';
import 'package:online_exam/core/theme/app_colors.dart';

class ExamCard extends StatelessWidget {
  final String? name;
  final int? duration;
  final int? numberOfQuestions;
  final String? createdAt;

  const ExamCard({
    super.key,
     this.name,
     this.duration,
     this.numberOfQuestions,
     this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.3,
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
          Expanded(
            flex:1,
            child:  SizedBox(
            width: 60,
            height: 70,
            child: Image.asset(AppAssets.examLogo),
          ),),
           Expanded(
               flex: 3,
               child:  Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                     name!,
                     style: Theme.of(context).textTheme.bodyLarge,
                   ),
                   Text(
                     "${duration} minute",
                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
                       color: AppColors.blue,
                     ),
                   )

                 ],
               ),
               Text(
                 "${numberOfQuestions} Questions",
                 style: Theme.of(context).textTheme.labelMedium?.copyWith(
                   color: AppColors.gray,
                 ),
               ),
               Text(
                 createdAt!,
                 style: Theme.of(context).textTheme.labelMedium,
               ),
             ],
           ))
        ],
      ),
    );
  }
}
