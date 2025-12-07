import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/Features/Questions/ui/questions/QuestionsViewModel.dart';
import 'package:online_exam/Features/Questions/ui/questions/QuestionsContract.dart';
import 'package:online_exam/Features/Questions/ui/questions/ScoreScreen.dart';
import 'package:online_exam/Features/Questions/ui/utls/TimeOutDialog.dart';
import 'package:online_exam/core/theme/app_colors.dart';
import 'package:online_exam/di.dart';

class QuestionsScreenEnhanced extends StatelessWidget {
  final String examId;
  const QuestionsScreenEnhanced({super.key, required this.examId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<QuestionsViewModel>()..doIntent(LoadExamQuestions(examId)),
      child: _QuestionsViewEnhanced(examId: examId),
    );
  }
}

class _QuestionsViewEnhanced extends StatelessWidget {
  final String examId;
  const _QuestionsViewEnhanced({super.key, required this.examId});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<QuestionsViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<QuestionsViewModel, QuestionsState>(
          listener: (context, state) {
            if (state is NavigateToResultState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScoreScreenEnhanced(
                      score: state.total?.toString() ?? "0%",
                      correct: state.correct ?? 0,
                      wrong: state.wrong ?? 0,
                      correctQuestions: state.correctQuestions ?? [],
                      wrongQuestions: state.wrongQuestions ?? [],
                      allQuestions: vm.exam!.questions!,
                      examId: examId,
                    ),
                  ),
                );
              });
            }
            if (state is TimeoutState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showTimeOutDialog(context, vm, examId);
              });
            }

          },
          builder: (context, state) {
            if (state is QuestionsLoadingState || vm.exam == null) {
              return const Center(child: CircularProgressIndicator(color : AppColors.blue));
            }

            if (state is QuestionsErrorState) {
              return Center(child: Text(state.message));
            }

            final exam = vm.exam!;
            final totalQuestions = exam.questions!.length;
            final currentIndex = vm.currentIndex;

            final question = exam.questions![currentIndex];
            final answers = question.answers ?? [];

            final initialSeconds =
                (exam.questions!.first.exam!.duration ?? 0) * 60;
            final remainingSeconds = vm.totalSeconds;

            final progress = (currentIndex + 1) / totalQuestions;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- APP BAR ----------------
                  Row(
                    children: [
                      const Icon(Icons.arrow_back, size: 22),
                      const SizedBox(width: 6),
                      const Text(
                        "Exam",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),

                      // Timer UI
                      Row(
                        children: [
                          Icon(Icons.timer_outlined, color: AppColors.blue),
                          const SizedBox(width: 4),
                          Text(
                            vm.formattedTime,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: Text(
                      "Question ${currentIndex + 1} of $totalQuestions",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // -------------- PROGRESS BAR ------------------
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 4,
                    backgroundColor: AppColors.lightBlue2,
                    color: AppColors.blue,
                  ),

                  const SizedBox(height: 20),

                  // ---------------- QUESTION TEXT ----------------
                  Text(
                    question.question ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ---------------- ANSWERS ----------------
                  Expanded(
                    child: ListView.builder(
                      itemCount: answers.length,
                      itemBuilder: (context, index) {
                        final ans = answers[index];
                        final isSelected =
                            vm.selectedAnswers.length > currentIndex &&
                                vm.selectedAnswers[currentIndex] == index;

                        return GestureDetector(
                          onTap: () {
                            vm.doIntent(
                                SelectAnswerIntent(currentIndex, index));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 14),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.lightBlue
                                  : AppColors.lightBlue2,
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(
                              //   color: isSelected
                              //       ? AppColors.blue
                              //       : AppColors.gray,
                              //   width: 1.3,
                              // ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.blue,
                                      width: 2,
                                    ),
                                    color: Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? Center(
                                          child: Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.blue,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    ans.answer ?? "",
                                    style: const TextStyle(
                                        fontSize: 15, color: AppColors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ---------------- BUTTONS ----------------
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: currentIndex == 0 ? null : vm.prevQuestion,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: AppColors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Back",
                            style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (currentIndex == totalQuestions - 1) {
                              vm.doIntent(SubmitExamIntent());
                            } else {
                              vm.nextQuestion();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: AppColors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            currentIndex == totalQuestions - 1
                                ? "Finish"
                                : "Next",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
