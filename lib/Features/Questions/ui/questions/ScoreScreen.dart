import 'package:flutter/material.dart';
import 'package:online_exam/Features/Questions/ui/questions/AnswerScreen.dart';
import 'package:online_exam/Features/Questions/ui/questions/QuestionsScreen.dart';
import 'package:online_exam/Features/Questions/ui/utls/ScoreCircularIndicator.dart';
import 'package:online_exam/core/theme/app_colors.dart' show AppColors;
import '../../api/model/response/check_questions_response.dart';

class ScoreScreenEnhanced extends StatelessWidget {
  final String score;
  final int correct;
  final int wrong;
  final String examId;

  final List<CorrectQuestions> correctQuestions;
  final List<WrongQuestions> wrongQuestions;

  final dynamic allQuestions;

  const ScoreScreenEnhanced({
    super.key,
    required this.score,
    required this.correct,
    required this.wrong,
    required this.correctQuestions,
    required this.wrongQuestions,
    required this.allQuestions,
    required this.examId,
  });

  // double _parsePercent(String s) {
  //   try {
  //     final cleaned = s.replaceAll('%', '');
  //     final value = double.parse(cleaned);
  //     return (value / 100).clamp(0.0, 1.0);
  //   } catch (_) {
  //     return 0.0;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final int total = (correct + wrong) == 0 ? 1 : (correct + wrong);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          "Exam score",
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              "Your score",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 22),

            // CIRCLE + RIGHT NUMBERS
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Animated circle
                ScoreCircularIndicator(
                  correctPercent: correct / total,
                  wrongPercent: wrong / total,
                ),
                const SizedBox(width: 24),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Correct",
                            style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(width: 32),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.blue,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.transparent,
                            child: Text(
                              "$correct",
                              style: const TextStyle(
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        const Text("Incorrect",
                            style: TextStyle(
                                color: AppColors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(width: 32),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.red,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.transparent,
                            child: Text(
                              "$wrong",
                              style: const TextStyle(
                                color: AppColors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(height: 40),

            // Show results BUTTON
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.042,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AnswersScreen(
                        correctQuestions: correctQuestions,
                        wrongQuestions: wrongQuestions,
                        allQuestions: allQuestions,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Show results",
                  style: TextStyle(fontSize: 17, color: AppColors.white),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Start again BUTTON
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.042,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => QuestionsScreenEnhanced(
                            examId:
                                examId)),
                    (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.blue, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Start again",
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
