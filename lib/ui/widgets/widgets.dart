import 'package:flutter/material.dart';

import 'package:citizensapp/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppBar AppBarr(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Text(AppLocalizations.of(context).crimeMaster),
  );
}

final FloatingActionButtonn = (context) => FloatingActionButton(onPressed: () {
      BlocProvider.of<ThemeCubit>(context).changetheme();
    });
