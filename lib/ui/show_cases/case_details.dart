import 'package:citizenapp2/cubits/theme_cubit/theme_cubit.dart';
import 'package:citizenapp2/models/case.dart';
import 'package:citizenapp2/services/data_calls.dart';
import 'package:citizenapp2/ui/widgets/fileicon.dart';
import 'package:citizenapp2/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CaseDetails extends StatefulWidget {
  String case_id;
  CaseDetails({Key? key, required this.case_id}) : super(key: key);

  @override
  State<CaseDetails> createState() => _CaseDetailsState();
}

class _CaseDetailsState extends State<CaseDetails> {
  final DataCall datacall = DataCall();
  final box = Hive.box("main");
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBarr(context),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: FutureBuilder<dynamic>(
                future: datacall.getCase(widget.case_id, box.get("jwt")),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                    case ConnectionState.active:
                      {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Please wait as we fetch your data"),
                            SpinKitWave(
                              color: context.read<ThemeCubit>().gettheme() ==
                                      "Light"
                                  ? Colors.black
                                  : Colors.teal,
                              size: 50.0,
                            )
                          ],
                        );
                      }
                    case ConnectionState.done:
                      {
                        if (snapshot.data != null) {
                          return Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: height / 15,
                                  width: width,
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(color: Colors.white)),
                                  child: Text("Crime Details",
                                      style:
                                          GoogleFonts.notoSans(fontSize: 24))),
                              Container(
                                height: height / 15,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("ID : ",
                                        style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20)),
                                    Text("${snapshot.data!.ID}"),
                                  ],
                                ),
                              ),
                              Container(
                                height: height / 8,
                                width: width,

                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text("Description : ",
                                          style: GoogleFonts.notoSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20)),
                                    ),
                                    Text("${snapshot.data!.description}"),
                                  ],
                                ),
                              ),
                              Container(
                                height: height / 15,
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Location : ",
                                        style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20)),
                                    Text(
                                        "${snapshot.data!.lat}  ${snapshot.data!.long} "),
                                  ],
                                ),
                              ),
                              Container(
                                height: height / 15,
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Offenders : ",
                                        style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20)),
                                    Text("${snapshot.data!.offenders}"),
                                  ],
                                ),
                              ),
                              Container(
                                height: height / 15,
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Victims : ",
                                        style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20)),
                                    Text("${snapshot.data!.victims}"),
                                  ],
                                ),
                              ),
                              Container(
                                height: height / 15,
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Date/Time : ",
                                        style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20)),
                                    Text("${snapshot.data!.time}"),
                                  ],
                                ),
                              ),
                              Container(
                                height: height / 15,
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Status : ",
                                        style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20)),
                                    Text("${snapshot.data!.status}"),
                                  ],
                                ),
                              ),
                              Text("Media : ",
                                  style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20)),
                              Center(
                                child: Container(
                                  height: 100,
                                  width: 300,
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(color: Colors.blue),
                                  // ),
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.file.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_, index) {
                                        return FileIcon(
                                            fileType: snapshot
                                                .data!.file[index].fileType,
                                            onDelete: () {},
                                            showdel: false);
                                      }),
                                ),
                              )
                            ],
                          );
                        } else
                          return Text("oomf");
                      }
                    default:
                      {
                        return Center(child: Text("weird error"));
                      }
                  }
                }),
          ),
        ));
  }
}
