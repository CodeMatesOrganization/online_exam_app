import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/Features/Auth/ui/widget/AppErrorWidget.dart';
import 'package:online_exam/Features/Subject/ui/Exams/ExamsContract.dart';
import 'package:online_exam/Features/Subject/ui/Exams/ExamsViewModel.dart';
import 'package:online_exam/Features/Subject/ui/widgets/ExamCard.dart';
import 'package:online_exam/di.dart';

class ExamsScreen extends StatefulWidget {
  const ExamsScreen({super.key});

  static const String routeName = "/exams";

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  late final ExamsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<ExamsViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Subject Name",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              BlocConsumer<ExamsViewModel, ExamsState>(
                listener: (context, state) async {
                  // 1. Loading
                  if (state is ExamsLoadingState) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) =>
                          Center(child: CircularProgressIndicator()),
                    );
                  }
                  // 2. Error
                  else if (state is ExamsErrorState) {
                    Navigator.of(context, rootNavigator: true).pop();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: AppErrorWidget(
                          exception: state.exception,
                          onRetry: () => Navigator.pop(context),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ExamsSuccessState) {
                    final exams = state.exams;
                    if (exams.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Center(
                          child: Text(
                            "There is no Exams yet",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...exams.map((exam) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment
                                    .centerLeft,
                                margin: EdgeInsets.all(12),
                                child: Text(
                                  exam.title!,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ),
                              ExamCard(
                                name: exam.title,
                                duration: exam.duration,
                                createdAt: exam.createdAt,
                                numberOfQuestions: exam.numberOfQuestions,
                              ),
                            ],
                          );
                        }),
                      ],
                    );
                  } else if (state is ExamsLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ExamsErrorState) {
                    return Center(child: Text("Error loading Exams"));
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
