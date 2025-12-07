import 'package:flutter/material.dart';
import 'package:online_exam/Features/Questions/ui/questions/QuestionsContract.dart';
import 'package:online_exam/Features/Questions/ui/questions/QuestionsViewModel.dart';
import 'package:online_exam/core/theme/app_colors.dart';

void showTimeOutDialog(BuildContext context, QuestionsViewModel vm, String examId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/sandclock.png",
                  width: 70,
                ),
                const SizedBox(height: 12),

                const Text(
                  "Time out !!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),

                const SizedBox(height: 22),
                SizedBox(
                  width: 180,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      vm.doIntent(SubmitExamIntent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "View score",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
