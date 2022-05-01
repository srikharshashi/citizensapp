import 'package:flutter/material.dart';

import 'package:citizensapp/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final AppBarr = AppBar(
  centerTitle: true,
  title: Text("CRIMEMASTER"),
);

final FloatingActionButtonn = (context) => FloatingActionButton(onPressed: () {
      BlocProvider.of<ThemeCubit>(context).changetheme();
    });
