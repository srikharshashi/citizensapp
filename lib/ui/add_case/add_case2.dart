import 'package:citizensapp/constants.dart';
import 'package:citizensapp/cubits/add_case_cubit/add_case_cubit.dart';
import 'package:citizensapp/cubits/file_upload_cubit/file_upload_cubit.dart';
import 'package:citizensapp/models/file.dart';
import 'package:citizensapp/ui/widgets/file_upload_custom.dart';
import 'package:citizensapp/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCase2 extends StatefulWidget {
  const AddCase2({Key? key}) : super(key: key);

  @override
  State<AddCase2> createState() => _AddCase2State();
}

class _AddCase2State extends State<AddCase2> {
  @override
  void initState() {
    // context.read<FileUploadCubit>().files.clear();
    context.read<FileUploadCubit>().reload();
    super.initState();
  }

  TextEditingController criminals = TextEditingController();
  TextEditingController victims = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBarr(context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                Container(
                  height: height / 12,
                  width: width,
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "tell us more!!(optionals)",
                        style: GoogleFonts.roboto(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  height: height / 5,
                  width: width,
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Criminal Details",
                        style: GoogleFonts.roboto(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: criminals,
                        keyboardType: TextInputType.multiline,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        maxLines: 1,
                      ),
                    ),
                  ]),
                ),
                Container(
                  height: height / 5,
                  width: width,
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Victim Details : ",
                        style: GoogleFonts.roboto(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: victims,
                        keyboardType: TextInputType.multiline,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        maxLines: 1,
                        // expands: true,
                      ),
                    ),
                  ]),
                ),
                Container(
                  height: height / 3,
                  width: width,
                  padding: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Related Media : ",
                            style: GoogleFonts.roboto(fontSize: 20),
                          ),
                        ),
                        BlocBuilder<FileUploadCubit, FileUploadState>(
                          builder: (context, state) {
                            if (state is FileUploadInitial) {
                              return CustomFileUpload(files: [
                                CustomFile(
                                    fileType: CustomFileType.newfile,
                                    ID: "abcd")
                              ]);
                            } else if (state is FileUploadLoad) {
                              return SpinKitWave(
                                color: context.read<ThemeCubit>().gettheme() ==
                                        "Light"
                                    ? Colors.black
                                    : Colors.teal,
                                size: 50.0,
                              );
                            } else if (state is FileUploadDone) {
                              return CustomFileUpload(files: state.files);
                            } else {
                              print("weird");
                              return Container();
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Container(
                            height: height / 20,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      context.read<ThemeCubit>().gettheme() ==
                                              "Light"
                                          ? Colors.black
                                          : Colors.teal,
                                )),
                            child: BlocConsumer<AddCaseCubit, AddCaseState>(
                                listener: (context, state) {
                              if (state is AddCase2Done)
                                Navigator.pushReplacementNamed(
                                    context, ADD_CASE3);
                            }, builder: (context, state) {
                              if (state is AddCase1Done) {
                                return MaterialButton(
                                  onPressed: () {
                                    var files = context
                                        .read<FileUploadCubit>()
                                        .getFileList();
                                    print(criminals.text);
                                    print(victims.text);
                                    context.read<AddCaseCubit>().step2done(
                                        criminals.text,
                                        victims.text,
                                        files,
                                        state.crimeType,
                                        state.description,
                                        state.position);
                                  },
                                  child: Text("Next"),
                                );
                              } else {
                                return Container(
                                  child: Text("Weird state error"),
                                );
                              }
                            }),
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
