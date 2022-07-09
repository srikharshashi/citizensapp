import 'package:citizensapp/constants.dart';
import 'package:citizensapp/cubits/location_cubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import '../../cubits/theme_cubit/theme_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:citizensapp/cubits/add_case_cubit/add_case_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCase1 extends StatefulWidget {
  const AddCase1({Key? key}) : super(key: key);

  @override
  State<AddCase1> createState() => _AddCase1State();
}

class _AddCase1State extends State<AddCase1> {
  @override
  String? val = null;

  TextEditingController textEditingController = TextEditingController();

  showtoast(String message) {
    Fluttertoast.showToast(
      msg: message, // message
      toastLength: Toast.LENGTH_SHORT, // length
      gravity: ToastGravity.BOTTOM, // location
      timeInSecForIosWeb: 4,
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<LocationCubit>().reload();
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<String> crimes = [
      AppLocalizations.of(context).theft,
      AppLocalizations.of(context).sexualHarrashment,
      AppLocalizations.of(context).homicide,
      AppLocalizations.of(context).terrorism,
      AppLocalizations.of(context).animalAbuse,
      AppLocalizations.of(context).childAbuse,
      AppLocalizations.of(context).domesticViolence
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context).crimeMaster),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: height / 12,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      AppLocalizations.of(context).addANewCase,
                      style: GoogleFonts.roboto(
                          fontSize: 40, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                //classification conatiner
                Container(
                  padding: EdgeInsets.all(18),
                  height: height / 7,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context).classifyTheCrime,
                                style: GoogleFonts.roboto(fontSize: 20),
                              ),
                              Text(
                                "*",
                                style: GoogleFonts.roboto(
                                    fontSize: 20, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: height / 20,
                        width: width,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.white),
                            ),
                        child: DropdownButton(
                            isExpanded: true,
                            value: val ?? crimes[0],
                            items: crimes.map((String vale) {
                              return DropdownMenuItem<String>(
                                value: vale,
                                child: Text(vale),
                              );
                            }).toList(),
                            onChanged: (e) {
                              print(e.toString());
                              val = e as String;

                              setState((() {}));
                            }),
                      )
                    ],
                  ),
                ),
                //description cont
                Container(
                  height: height / 2.9,
                  padding: EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context).describeTheCrime,
                                style: GoogleFonts.roboto(fontSize: 20),
                              ),
                              Text(
                                "*",
                                style: GoogleFonts.roboto(
                                    fontSize: 20, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        child: TextField(
                          controller: textEditingController,
                          keyboardType: TextInputType.multiline,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          maxLines: 9,
                          // expands: true,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: height / 6.5,
                  width: width,
                  padding: EdgeInsets.all(15),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Row(
                          children: [
                            Text(AppLocalizations.of(context).selectALocation,
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                )),
                            Text(
                              "*",
                              style: GoogleFonts.roboto(
                                  fontSize: 20, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: height / 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<LocationCubit, LocationState>(
                            builder: (context, state) {
                              if (state is LocationInitial) {
                                return Container(
                                  height: height / 7,
                                  width: width / 2.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<LocationCubit>()
                                              .getLocation();
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .gotTheLocation,
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                );
                              } else if (state is LocationLoad) {
                                return Container(
                                  height: height / 7,
                                  width: width / 2.5,
                                  child: SpinKitWave(
                                    size: 30,
                                    color:
                                        context.read<ThemeCubit>().gettheme() ==
                                                "Light"
                                            ? Colors.black
                                            : Colors.teal,
                                  ),
                                );
                              } else if (state is LocationGot) {
                                return Container(
                                    height: height / 8,
                                    width: width / 2.5,
                                    child: Center(
                                        child: Text(
                                      AppLocalizations.of(context)
                                          .gotTheLocation,
                                      style: GoogleFonts.roboto(fontSize: 17),
                                    )));
                              } else if (state is LocationError) {
                                return Container(
                                    height: height / 7,
                                    // width: width / ,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("There was an Error ❌ "),
                                        ElevatedButton(
                                            onPressed: () async {
                                              LocationPermission permission =
                                                  await Geolocator
                                                      .checkPermission();
                                              if (permission ==
                                                  LocationPermission.denied) {
                                                LocationPermission p2 =
                                                    await Geolocator
                                                        .requestPermission();
                                              }
                                              context
                                                  .read<LocationCubit>()
                                                  .reload();
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)
                                                    .retry))
                                      ],
                                    ));
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
                BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, locationstate) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                context.read<ThemeCubit>().gettheme() == "Light"
                                    ? Colors.black
                                    : Colors.teal,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: MaterialButton(
                          onPressed: () {
                            if (textEditingController.text.length > 10) {
                              if (locationstate is LocationGot) {
                                if (val != null) {
                                  context.read<AddCaseCubit>().step1done(
                                      textEditingController.text,
                                      val!,
                                      locationstate.position);
                                  Navigator.pushReplacementNamed(
                                      context, ADD_CASE2);
                                } else
                                  showtoast("Select a Classification");
                              } else
                                showtoast("Submit your location first");
                            } else
                              showtoast("Enter a valid/longer description");
                          },
                          child: Text(AppLocalizations.of(context).next)),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
