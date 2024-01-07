import 'package:flutter/material.dart';

ThemeData createLightTheme() => ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
);