import 'package:flutter/material.dart';
import 'package:online_exam/Features/Questions/api/model/response/questions_response.dart';
import 'package:online_exam/Features/Questions/ui/questions/AnswerScreen.dart';
import 'package:online_exam/Features/Result/ResultPref.dart';
import 'package:online_exam/Features/Result/model/ExamResultModel.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<ExamResultModel> results = [];

  @override
  void initState() {
    super.initState();
    loadResults();
  }

  Future<void> loadResults() async {
    results = await ResultStorageService.loadExamResults();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Results")),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (_, i) {
          final r = results[i];
          return ListTile(
            title: Text(r.title),
            subtitle: Text("${r.correct} correct out of ${r.totalQuestions}"),
            trailing: Text(
              "${r.date.day}/${r.date.month}",
              style: const TextStyle(color: Colors.grey),
            ),
            onTap: () {
              final parsedAll = r.allQuestions
                  .map((e) => Questions.fromJson(e))
                  .toList();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AnswersScreen(
                    correctQuestions: r.correctQuestions,
                    wrongQuestions: r.wrongQuestions,
                    allQuestions: parsedAll,
                  ),
                ),
              );
            },

          );
        },
      ),
    );
  }
}
