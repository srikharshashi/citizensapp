import 'package:citizenapp2/constants.dart';
import 'package:citizenapp2/cubits/add_case_cubit/add_case_cubit.dart';
import 'package:citizenapp2/cubits/final_report/final_report_cubit.dart';
import 'package:citizenapp2/cubits/theme_cubit/theme_cubit.dart';
import 'package:citizenapp2/models/question.dart';
import 'package:citizenapp2/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCase3 extends StatefulWidget {
  const AddCase3({Key? key}) : super(key: key);

  @override
  State<AddCase3> createState() => _AddCase3State();
}

class _AddCase3State extends State<AddCase3> {
  showtoast(String message) {
    Fluttertoast.showToast(
      msg: message, // message
      toastLength: Toast.LENGTH_SHORT, // length
      gravity: ToastGravity.BOTTOM, // location
      timeInSecForIosWeb: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int q1S = -1;
    int q2s = -1;

    var buttonoption = GroupButtonOptions(
      groupingType: GroupingType.column,
      selectedColor: context.read<ThemeCubit>().gettheme() == "Light"
          ? Colors.black
          : Colors.teal,
      unselectedTextStyle: TextStyle(
        color: context.read<ThemeCubit>().gettheme() == "Light"
            ? Colors.black
            : Colors.white,
      ),
      borderRadius: BorderRadius.circular(20),
      unselectedBorderColor: context.read<ThemeCubit>().gettheme() == "Light"
          ? Colors.black
          : Colors.teal,
    );

    return Scaffold(
      appBar: AppBarr(context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
            //title
            Container(
              height: height / 9,
              width: width,
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "answer these and we'll be done",
                    style: GoogleFonts.roboto(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            //question1
            Container(
              height: height / 3.1,
              width: width,
              padding: EdgeInsets.all(10),
              child: BlocBuilder<AddCaseCubit, AddCaseState>(
                builder: (context, state) {
                  if (state is AddCase2Done) {
                    List<Question> question = context
                        .read<AddCaseCubit>()
                        .getQuestion(state.crimeType);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "1) " + question[0].question,
                          style: GoogleFonts.roboto(fontSize: 20),
                        ),
                        GroupButton(
                          isRadio: true,
                          options: buttonoption,
                          buttons: [question[0].option1, question[0].option2],
                          onSelected: (str, index, b) {
                            q1S = index;
                          },
                        )
                      ],
                    );
                  } else {
                    return Container(
                      child: Text("oomf state"),
                    );
                  }
                },
              ),
            ),
            //question2
            Container(
              height: height / 3.1,
              width: width,
              // decoration:
              // BoxDecoration(border: Border.all(color: Colors.white)),
              child: BlocBuilder<AddCaseCubit, AddCaseState>(
                builder: (context, state) {
                  if (state is AddCase2Done) {
                    List<Question> question = context
                        .read<AddCaseCubit>()
                        .getQuestion(state.crimeType);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "2) " + question[1].question,
                          style: GoogleFonts.roboto(fontSize: 20),
                        ),
                        GroupButton(
                          isRadio: true,
                          options: buttonoption,
                          buttons: [question[1].option1, question[1].option2],
                          onSelected: (str, index, b) {
                            q2s = index;
                          },
                        )
                      ],
                    );
                  } else {
                    return Container(
                      child: Text("oomf state"),
                    );
                  }
                },
              ),
            ),
            Container(
              height: height / 13,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.read<ThemeCubit>().gettheme() == "Light"
                        ? Colors.black
                        : Colors.teal,
                  )),
              child: BlocConsumer<AddCaseCubit, AddCaseState>(
                  listener: (context, state) {
                if (state is AddCase3Done) {
                  context.read<FinalReportCubit>().reportCase(
                      state.criminals,
                      state.victims,
                      state.files,
                      state.crimeType,
                      state.description,
                      state.position);

                  Navigator.pushReplacementNamed(context, FINAL_REPORT);
                }
              }, builder: (context, state) {
                if (state is AddCase2Done) {
                  var question =
                      context.read<AddCaseCubit>().getQuestion(state.crimeType);
                  return MaterialButton(
                    onPressed: () {
                      if (q1S != -1 && q2s != -1) {
                        if (q1S == question[0].corectoption) {
                          if (q2s == question[1].corectoption) {
                            context.read<AddCaseCubit>().step3done(
                                state.criminals,
                                state.victims,
                                state.files,
                                state.crimeType,
                                state.description,
                                state.position);
                          } else {
                            showtoast("One or more questions are wrong");
                          }
                        } else {
                          showtoast("One or more questions are wrong");
                        }
                      } else {
                        showtoast("Select desired options");
                      }
                    },
                    child: Text("report the case "),
                  );
                } else {
                  return Container();
                }
              }),
            )
            //proceed button
          ]),
        ),
      ),
    );
  }
}
