import 'package:citizenapp2/cubits/auth_status_cubit/auth_status_cubit.dart';
import 'package:citizenapp2/cubits/fetch_cases_cubit/fetch_cases_cubit.dart';
import 'package:citizenapp2/cubits/file_upload_cubit/file_upload_cubit.dart';
import 'package:citizenapp2/cubits/final_report/final_report_cubit.dart';
import 'package:citizenapp2/cubits/locale_cubit/locale_cubit_cubit.dart';
import 'package:citizenapp2/cubits/location_cubit/location_cubit.dart';
import 'package:citizenapp2/cubits/login_cubit/login_cubit.dart';
import 'package:citizenapp2/cubits/settings_cubit/settings_cubit.dart';
import 'package:citizenapp2/cubits/signup_cubit/signup_cubit.dart';
import 'package:citizenapp2/cubits/splash_screen/splashscreen_cubit.dart';
import 'package:citizenapp2/cubits/theme_cubit/theme_cubit.dart';
import 'package:citizenapp2/router.dart';
import 'package:citizenapp2/services/auth_service.dart';
import 'package:citizenapp2/services/data_calls.dart';
import 'package:citizenapp2/services/file_upload.dart';
import 'package:citizenapp2/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/add_case_cubit/add_case_cubit.dart';
import 'l10n/l1on.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("main");

  runApp(MyApp());
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
        ),
        BlocProvider(
          create: (context) => LocaleCubit(),
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themestate) {
          return BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, state) {
              return MaterialApp(
                supportedLocales: I10n.all,
                locale: context.read<LocaleCubit>().state.locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                onGenerateRoute: appRouter.onGenerateRoute,
                debugShowCheckedModeBanner: false,
                theme: themestate.themeData,
              );
            },
          );
        },
      ),
    );
  }
}
