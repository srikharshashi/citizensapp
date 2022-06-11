import 'package:citizensapp/cubits/auth_status_cubit/auth_status_cubit.dart';
import 'package:citizensapp/cubits/fetch_cases_cubit/fetch_cases_cubit.dart';
import 'package:citizensapp/cubits/file_upload_cubit/file_upload_cubit.dart';
import 'package:citizensapp/cubits/final_report/final_report_cubit.dart';
import 'package:citizensapp/cubits/location_cubit/location_cubit.dart';
import 'package:citizensapp/cubits/login_cubit/login_cubit.dart';
import 'package:citizensapp/cubits/settings_cubit/settings_cubit.dart';
import 'package:citizensapp/cubits/signup_cubit/signup_cubit.dart';
import 'package:citizensapp/cubits/splash_screen/splashscreen_cubit.dart';
import 'package:citizensapp/cubits/theme_cubit/theme_cubit.dart';
import 'package:citizensapp/router.dart';
import 'package:citizensapp/services/auth_service.dart';
import 'package:citizensapp/services/data_calls.dart';
import 'package:citizensapp/services/file_upload.dart';
import 'package:citizensapp/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/add_case_cubit/add_case_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("main");
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    fallbackLocale: Locale("en"),
      path: 'assets/translations',
      supportedLocales: [Locale("en"), Locale("hi")],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AppRouter appRouter = AppRouter();
  final AuthService authService = AuthService();
  final FileUploader fileUploader = FileUploader();
  final LocationService locationService = LocationService();
  final DataCall dataCall = DataCall();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(authService: authService),
        ),
        BlocProvider(
          create: (context) => FileUploadCubit(fileUploader: fileUploader),
        ),
        BlocProvider(
          create: (context) => SignupCubit(authService: authService),
        ),
        BlocProvider(
          create: (context) => SplashscreenCubit(),
        ),
        BlocProvider(
          create: (context) => AuthstatusCubit(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(authService: authService),
        ),
        BlocProvider(
            create: (context) =>
                LocationCubit(locationService: locationService)),
        BlocProvider(
          create: (context) => AddCaseCubit(),
        ),
        BlocProvider(
          create: (context) => FinalReportCubit(dataCall: dataCall),
        ),
        BlocProvider(
          create: (context) => FetchCasesCubit(dataCall: dataCall),
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themestate) {
          return MaterialApp(
            onGenerateRoute: appRouter.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            theme: themestate.themeData,
          );
        },
      ),
    );
  }
}
