import 'package:citizenapp2/constants.dart';
import 'package:citizenapp2/cubits/auth_status_cubit/auth_status_cubit.dart';
import 'package:citizenapp2/cubits/splash_screen/splashscreen_cubit.dart';
import 'package:citizenapp2/cubits/theme_cubit/theme_cubit.dart';
import 'package:citizenapp2/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBarr(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.white),
                      ),
                  height: height / 2.1,
                  width: width,
                  child: SvgPicture.asset(
                    "lib/assets/police.svg",
                    // color: Colors.red,
                  )),
              Container(
                height: height / 3.5,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.white),
                    ),
                child: BlocConsumer<SplashscreenCubit, SplashscreenState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is ToHome) {
                      context.read<AuthstatusCubit>().login(state.name);
                      Navigator.pushReplacementNamed(context, HOME_ROUTE);
                    } else if (state is SessionExpired) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Session Expired! Relogin!"),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SplashscreenInitial) {
                      return Container(
                        child: Center(
                          child: Text("initial"),
                        ),
                      );
                    } else if (state is ConnectivityError) {
                      return Container(
                        child: Text("Internet Error"),
                      );
                    } else if (state is ShowButtons ||
                        state is SessionExpired) {
                      return Container(
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, LOGIN_PAGE);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.5,
                                      color: context
                                          .read<ThemeCubit>()
                                          .state
                                          .themeData
                                          .primaryColor),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                height: height / 11,
                                width: width / 3,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context).login,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, SIGNUP_PAGE);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.5,
                                        color: context
                                            .read<ThemeCubit>()
                                            .state
                                            .themeData
                                            .primaryColor),
                                    borderRadius: BorderRadius.circular(20.0)),
                                height: height / 11,
                                width: width / 3,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context).signUp,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Text("uhh weird"),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
