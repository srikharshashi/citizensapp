import 'package:citizenapp2/constants.dart';
import 'package:citizenapp2/ui/add_case/add_case1.dart';
import 'package:citizenapp2/ui/add_case/add_case2.dart';
import 'package:citizenapp2/ui/add_case/add_case3.dart';
import 'package:citizenapp2/ui/add_case/final_report.dart';
import 'package:citizenapp2/ui/home.dart';
import 'package:citizenapp2/ui/loginpage.dart';
import 'package:citizenapp2/ui/settings.dart';
import 'package:citizenapp2/ui/show_cases/show_case.dart';
import 'package:citizenapp2/ui/signuppage.dart';
import 'package:citizenapp2/ui/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SPLASH_SCREEN:
        return PageTransition(
            child: SplashScreen(), type: PageTransitionType.rightToLeft);
      case HOME_ROUTE:
        return PageTransition(
            child: Home(), type: PageTransitionType.rightToLeft);
      case LOGIN_PAGE:
        return PageTransition(
            child: Login(), type: PageTransitionType.rightToLeft);
      case SIGNUP_PAGE:
        return PageTransition(
            child: SignUp(), type: PageTransitionType.rightToLeft);
      case SETTINGS:
        return PageTransition(
            child: Settings(), type: PageTransitionType.rightToLeft);
      case ADD_CASE1:
        return PageTransition(
            child: AddCase1(), type: PageTransitionType.rightToLeft);
      case ADD_CASE2:
        return PageTransition(
            child: AddCase2(), type: PageTransitionType.rightToLeft);
      case ADD_CASE3:
        return PageTransition(
            child: AddCase3(), type: PageTransitionType.rightToLeft);
      case FINAL_REPORT:
        return PageTransition(
            child: FinalReport(), type: PageTransitionType.rightToLeft);
      case FETCH_CASES:
        return PageTransition(
            child: ShowCases(), type: PageTransitionType.rightToLeft);
      default:
        return null;
    }
  }
}
