import 'package:citizenapp2/cubits/emergency_cubit/emergency_cubit.dart';
import 'package:citizenapp2/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Emergency extends StatefulWidget {
  Emergency({Key? key}) : super(key: key);

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  @override
  void initState() {
    context.read<EmergencyCubit>().emergency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarr(context),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Container(
            height: height,
            width: width,
            child: BlocBuilder<EmergencyCubit, EmergencyState>(
              builder: (context, state) {
                if (state is EmergencyInitial || state is EmergencyLoad) {
                  return Center(
                      child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "The Emegency is being reported ",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 30),
                        ),
                        Text(
                          "Please keep your location ON as we report",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 30),
                        ),
                        SpinKitDualRing(color: Colors.red, size: 70)
                      ],
                    ),
                  ));
                } else if (state is EmergencySucess) {
                  return Center(
                    child: Text("YOUR EMERGENCY WAS REPORTED"),
                  );
                } else if (state is EmergencyError) {
                  return Column(
                    children: [
                      Text(" there was a weird error"),
                      ElevatedButton(
                          onPressed: () {
                            context.read<EmergencyCubit>().emergency();
                          },
                          child: Text("Retry"))
                    ],
                  );
                } else
                  return Container(
                    child: Text("weird state"),
                  );
              },
            ),
          ),
        ),
      ),
    );
  }
}
