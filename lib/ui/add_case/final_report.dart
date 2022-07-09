import 'package:citizensapp/cubits/final_report/final_report_cubit.dart';
import 'package:citizensapp/cubits/theme_cubit/theme_cubit.dart';
import 'package:citizensapp/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalReport extends StatefulWidget {
  const FinalReport({Key? key}) : super(key: key);

  @override
  State<FinalReport> createState() => _FinalReportState();
}

class _FinalReportState extends State<FinalReport> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarr(context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
            height: height,
            width: width,
            child: BlocBuilder<FinalReportCubit, FinalReportState>(
              builder: (context, state) {
                if (state is FinalReportInitial || state is FinalReportLoad) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "please wait as submit your case",
                        style: GoogleFonts.roboto(fontSize: 20),
                      ),
                      SpinKitWave(
                        size: 50,
                        color: context.read<ThemeCubit>().gettheme() == "Light"
                            ? Colors.black
                            : Colors.teal,
                      )
                    ],
                  ));
                } else if (state is FinalReportSuccess) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Your case has been reported",
                          style: GoogleFonts.roboto(fontSize: 20),
                        ),
                        Lottie.network(
                            "https://assets7.lottiefiles.com/packages/lf20_sewgxnuc.json",
                            height: 200,
                            width: 200, onLoaded: (composition) {
                          // Future.delayed(Duration(seconds: 3));
                          // _controller.stop();
                        })
                      ]);
                } else {
                  return Center(
                    child: Text("there was a weird error"),
                  );
                }
              },
            )),
      ),
    );
  }
}
