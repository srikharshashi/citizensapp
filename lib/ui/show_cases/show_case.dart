import 'package:citizensapp/cubits/fetch_cases_cubit/fetch_cases_cubit.dart';
import 'package:citizensapp/cubits/theme_cubit/theme_cubit.dart';
import 'package:citizensapp/ui/show_cases/case_details.dart';
import 'package:citizensapp/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class ShowCases extends StatefulWidget {
  ShowCases({Key? key}) : super(key: key);

  @override
  State<ShowCases> createState() => _ShowCasesState();
}

class _ShowCasesState extends State<ShowCases> {
  @override
  void initState() {
    context.read<FetchCasesCubit>().getCases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarr,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: BlocBuilder<FetchCasesCubit, FetchCasesState>(
              builder: (context, state) {
            if (state is FetchCasesInitial || state is FetchCasesLoad) {
              return Center(
                  child: SpinKitWave(
                color: context.read<ThemeCubit>().gettheme() == "Light"
                    ? Colors.black
                    : Colors.teal,
                size: 50.0,
              ));
            } else if (state is FetchCasesDone) {
              
              return ListView.builder(
                  itemCount: state.cases.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child:
                                    CaseDetails(case_id: state.cases[index])));
                      },
                      title: Text(state.cases[index]),
                    );
                  });
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(" There was a weird error"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<FetchCasesCubit>().getCases();
                        },
                        child: Text("retry"))
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
