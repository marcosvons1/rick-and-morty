import 'package:flutter/material.dart';

final lightThemeData = ThemeData.light();

final darkThemeData = ThemeData.dark().copyWith(
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF5CAD4A),
    textTheme: ButtonTextTheme.primary,
  ),
);
