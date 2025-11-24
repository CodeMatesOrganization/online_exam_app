import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/Features/Auth/ui/widget/AppErrorWidget.dart';
import 'package:online_exam/Features/Auth/ui/widget/custome_text.dart';
import 'package:online_exam/Features/Subject/ui/Exams/ExamsScreen.dart';
import 'package:online_exam/Features/Subject/ui/Subjects/SubjectContract.dart';
import 'package:online_exam/Features/Subject/ui/Subjects/SubjectViewModel.dart';
import 'package:online_exam/Features/Subject/ui/widgets/SubjectCard.dart';
import 'package:online_exam/di.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  static const String routeName = "/home_subject";


  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  late TextEditingController searchController;

  late final SubjectViewModel viewModel ;


  void initState() {
    super.initState();
    searchController = TextEditingController();
    viewModel = getIt<SubjectViewModel>();

  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => viewModel,
    child: Scaffold(
      appBar: AppBar(
        title: Text("Survey" ,
          style:Theme.of(context).textTheme.headlineSmall ,),
      ),
      body: SingleChildScrollView(
        padding:EdgeInsets.all(8),
        child: Column(
          children:[
            CustomTextField(
            hintText: "Search",
              controller: searchController,
            isSearch: true,
             ) ,
            Container(
              alignment: Alignment.centerLeft, // يثبت النص على الشمال
              margin: EdgeInsets.all(12),
              child: Text("Browse by subject",
                style:Theme.of(context).textTheme.titleMedium ,),
            ),
            BlocConsumer<SubjectViewModel, SubjectState>(
              listener: (context, state) async {
                // 1. Loading
                if (state is SubjectLoadingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => Center(child: CircularProgressIndicator()),
                  );
                }
                // 2. Error
                else if (state is SubjectErrorState) {
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
                }else if (state is NavigateToSubjectState){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ExamsScreen()),
                  );
                }
              },
                builder: (context, state) {
                  if (state is SubjectSuccessState) {
                    final subjects = state.subjects;
                    return Column(
                      children: subjects.map((subj) =>
                          InkWell(
                            onTap: () {
                              viewModel.doIntent(NavigateToSubjectIntent(subj.Id));
                            },
                            child: SubjectCard(name: subj.name ?? "", icon: subj.icon ?? " ") ,
                          )
                      ).toList(),
                    );
                  } else if (state is SubjectLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SubjectErrorState) {
                    return Center(child: Text("Error loading subjects"));
                  } else {
                    return SizedBox.shrink();
                  }
                }

            ),


          ]),
      ) ,
    )
    );
  }


}
