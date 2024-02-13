import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    background: const Color.fromARGB(255, 81, 194, 250),
    primary: Colors.blueGrey.shade500,
    secondary: Colors.blueGrey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
  useMaterial3: true,
);