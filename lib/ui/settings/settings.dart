import 'package:citizenapp2/constants.dart';
import 'package:citizenapp2/cubits/locale_cubit/locale_cubit_cubit.dart';
import 'package:citizenapp2/cubits/settings_cubit/settings_cubit.dart';
import 'package:citizenapp2/cubits/splash_screen/splashscreen_cubit.dart';
import 'package:citizenapp2/cubits/theme_cubit/theme_cubit.dart';
import 'package:citizenapp2/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../cubits/auth_status_cubit/auth_status_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController ETHCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    int gettheme() {
      return BlocProvider.of<ThemeCubit>(context).gettheme() == "Light" ? 0 : 1;
    }

    return Scaffold(
      appBar: AppBarr(context),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context).settings,
                style: GoogleFonts.notoSans(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Container(
                  height: height / 10,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        AppLocalizations.of(context).language,
                        style: GoogleFonts.notoSans(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      ToggleSwitch(
                        minWidth: 70.0,
                        initialLabelIndex:
                            context.read<LocaleCubit>().getLocale(),
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        labels: ["??????????????????", "English"],
                        activeBgColors: [
                          [Colors.blue],
                          [Colors.teal]
                        ],
                        onToggle: (index) {
                          context.read<LocaleCubit>().changeLocale();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Container(
                  height: height / 10,
                  padding: EdgeInsets.all(10),
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        AppLocalizations.of(context).theme,
                        style: GoogleFonts.notoSans(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      ToggleSwitch(
                        minWidth: 60.0,
                        initialLabelIndex: gettheme(),
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        icons: [FontAwesomeIcons.sun, FontAwesomeIcons.moon],
                        activeBgColors: [
                          [Colors.blue],
                          [Colors.teal]
                        ],
                        onToggle: (index) {
                          context.read<ThemeCubit>().changetheme();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    if (state is SettingsInitial) {
                      return Container(
                        height: height / 6,
                        width: width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  height: height / 15,
                                  width: width / 1.2,
                                  child: TextField(
                                    controller: ETHCont,
                                  )),
                            ),
                            ElevatedButton(
                              child: Text(AppLocalizations.of(context)
                                  .changeWalletAddress),
                              onPressed: () {
                                context
                                    .read<SettingsCubit>()
                                    .changeETH(ETHCont.text);
                              },
                            )
                          ],
                        ),
                      );
                    } else if (state is ChangeETHLoad) {
                      return Container(
                        height: height / 6,
                        width: width,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                  "Please wait as we change the Wallet address"),
                              SpinKitWave(
                                size: 50,
                                color: context.read<ThemeCubit>().gettheme() ==
                                        "Light"
                                    ? Colors.black
                                    : Colors.teal,
                              )
                            ],
                          ),
                        ),
                      );
                    } else if (state is ChangeETHSucess) {
                      return Container(
                        height: height / 6,
                        width: width,
                        child: Center(
                          child: Column(
                            children: [
                              Text("Your Wallet Address was changed!"),
                              ElevatedButton(
                                  onPressed: () {
                                    context.read<SettingsCubit>().reload();
                                  },
                                  child:
                                      Text(AppLocalizations.of(context).reload))
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: height / 6,
                        width: width,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                  "There was an error in changing your Wallet Address!"),
                              ElevatedButton(
                                  onPressed: () {
                                    context.read<SettingsCubit>().reload();
                                  },
                                  child:
                                      Text(AppLocalizations.of(context).reload))
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      context.read<AuthstatusCubit>().logout();
                      context.read<SplashscreenCubit>().initialize();
                      Navigator.pushNamedAndRemoveUntil(
                          context, SPLASH_SCREEN, (route) => false);
                    },
                    child: Container(
                      width: width / 2.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: context.read<ThemeCubit>().gettheme() ==
                                      "Light"
                                  ? Colors.black
                                  : Colors.teal)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context).logOut,
                            style: GoogleFonts.notoSans(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Icon(FontAwesomeIcons.rightFromBracket)
                        ],
                      ),
                    ),
                  ),
                  height: height / 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
