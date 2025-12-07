import 'package:flutter/material.dart';
import 'package:online_exam/Features/Questions/api/model/response/check_questions_response.dart';
import 'package:online_exam/Features/Questions/api/model/response/questions_response.dart';
import 'package:online_exam/core/theme/app_colors.dart';

class AnswersScreen extends StatelessWidget {
  final List<CorrectQuestions> correctQuestions;
  final List<WrongQuestions> wrongQuestions;
  final List<Questions> allQuestions;

  const AnswersScreen({
    super.key,
    required this.correctQuestions,
    required this.wrongQuestions,
    required this.allQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final merged = [
      ...correctQuestions.map((e) => _AnswerItem.correct(e)),
      ...wrongQuestions.map((e) => _AnswerItem.wrong(e)),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Answers")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: merged.length,
        itemBuilder: (context, index) {
          return merged[index].buildWidget(allQuestions);
        },
      ),
    );
  }
}

class _AnswerItem {
  final CorrectQuestions? correct;
  final WrongQuestions? wrong;

  _AnswerItem.correct(this.correct) : wrong = null;
  _AnswerItem.wrong(this.wrong) : correct = null;

  bool get isCorrect => correct != null;

  Widget buildWidget(List<Questions> allQuestions) {
    if (isCorrect) {
      return _CorrectQuestionCard(correct!, allQuestions);
    } else {
      return _WrongQuestionCard(wrong!, allQuestions);
    }
  }
}

class _CorrectQuestionCard extends StatelessWidget {
  final CorrectQuestions q;
  final List<Questions> all;

  const _CorrectQuestionCard(this.q, this.all);

  @override
  Widget build(BuildContext context) {
    final original = all.firstWhere((e) => e.Id == q.QID);

    return _QuestionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(original.question ?? "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...original.answers!.map((ans) {
            return _OptionTile(
              text: ans.answer!,
              isCorrect: ans.key == q.correctAnswer,
              isUserWrong: false,
            );
          }),
        ],
      ),
    );
  }
}

class _WrongQuestionCard extends StatelessWidget {
  final WrongQuestions q;
  final List<Questions> all;

  const _WrongQuestionCard(this.q, this.all);

  @override
  Widget build(BuildContext context) {
    final original = all.firstWhere((e) => e.Id == q.QID);

    return _QuestionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(original.question ?? "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),

          // نعرض كل الإجابات ونحدد حالتها
          ...original.answers!.map((ans) {
            bool isCorrectAnswer = ans.key == q.correctAnswer;
            bool isUserWrong = ans.key == q.inCorrectAnswer;

            return _OptionTile(
              text: ans.answer!,
              isCorrect: isCorrectAnswer,
              isUserWrong: isUserWrong,
            );
          }),
        ],
      ),
    );
  }
}

class _QuestionContainer extends StatelessWidget {
  final Widget child;

  const _QuestionContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String text;
  final bool isCorrect;
  final bool isUserWrong;

  const _OptionTile({
    required this.text,
    required this.isCorrect,
    required this.isUserWrong,
  });

  @override
  Widget build(BuildContext context) {
    Color color = AppColors.lightBlue2;
    Color border = Colors.transparent;
    IconData icon = Icons.circle_outlined;
    Color iconColor = AppColors.blue;

    if (isCorrect) {
      color = Colors.green.shade100;
      border = AppColors.green;
      icon = Icons.check_circle;
      iconColor = Colors.green;
    } else if (isUserWrong) {
      color = Colors.red.shade100;
      border = AppColors.red;
      icon = Icons.cancel;
      iconColor = AppColors.red;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border, width: 1.5),
        color: color,
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
