import 'package:citizenapp2/cubits/auth_status_cubit/auth_status_cubit.dart';
import 'package:citizenapp2/cubits/splash_screen/splashscreen_cubit.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<AuthstatusCubit, AuthstatusState>(
      builder: (context, state) {
        if (state is LoggedIn) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        context.read<AuthstatusCubit>().logout();
                        context.read<SplashscreenCubit>().initialize();
                        Navigator.pushNamedAndRemoveUntil(
                            context, SPLASH_SCREEN, (route) => false);
                      },
                      child: Icon(FontAwesomeIcons.rightFromBracket)),
                )
              ],
              centerTitle: true,
              title: Text(AppLocalizations.of(context).crimeMaster),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context).welcome,
                            style: GoogleFonts.notoSans(
                                fontSize: 22, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "  ${state.username}",
                            style: GoogleFonts.notoSans(
                                fontSize: 22, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * (2.1 / 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, ADD_CASE1);
                                },
                                child: Card(
                                  elevation: 5,
                                  surfaceTintColor: Colors.white10,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: height / 5,
                                    width: width / 2,
                                    decoration: BoxDecoration(),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(FontAwesomeIcons
                                                .fileCirclePlus),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)
                                                .reportANewCase,
                                            style: GoogleFonts.notoSans(
                                                fontSize: 18),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, EMERGENCY);
                                },
                                child: Card(
                                  elevation: 5,
                                  surfaceTintColor:
                                      Color.fromARGB(255, 204, 61, 51),
                                  child: Container(
                                    height: height / 5,
                                    width: width / 2.5,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 201, 48, 48),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.warning),
                                          Text(
                                              AppLocalizations.of(context)
                                                  .emergency,
                                              style: GoogleFonts.notoSans(
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, FETCH_CASES);
                            },
                            child: Card(
                              elevation: 5,
                              surfaceTintColor: Colors.white10,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: height / 5,
                                width: width,
                                decoration: BoxDecoration(),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Icon(FontAwesomeIcons.newspaper),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .viewReportedCases,
                                        style:
                                            GoogleFonts.notoSans(fontSize: 18),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, SETTINGS);
                            },
                            child: Card(
                              elevation: 5,
                              surfaceTintColor: Colors.white10,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: height / 5,
                                width: width,
                                decoration: BoxDecoration(),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Icon(FontAwesomeIcons.gear),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .appSettings,
                                        style:
                                            GoogleFonts.notoSans(fontSize: 18),
                                      ),
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: Text("unknown state")),
          );
        }
      },
    );
  }
}
