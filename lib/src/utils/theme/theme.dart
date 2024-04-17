import 'package:chahel_web_1/src/utils/theme/custom_theme/text_theme.dart';
import 'package:flutter/material.dart';

class BAppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: BTextTheme.lightTextTheme,
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: BTextTheme.darkTextTheme,
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
  );
}
