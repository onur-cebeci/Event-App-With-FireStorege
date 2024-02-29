// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomThemeData {
  static const Color primaryColorLight = Color(0xffFF4E4E);
  static const Color primaryColor = Color(0xffFF2424);
  static const Color primaryColorDark = Color(0xffBE0000);
  static const Color primaryColorDarken = Color(0xffA41010);
  static const Color scaffoldBackgroundColor = Color(0xffF5F5F5);
  static const Color dialogBackgroundColor = Color(0xffFFFFFF);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color disabledColor = Color(0xffDDDDDD);
  static const Color backgroudColor = Color(0xffF4F4F4);

  static const Color disabledColorDark = Color(0xff6E6E6E);
  static const Color blackColor = Color(0xff000000);
  static const Color blackColorLight = Color(0xff3f3f3f);

  static const Color blueColor = Color.fromARGB(255, 37, 60, 100);
  static const Color blueColorDark = Color(0xff061434);

  static ThemeData customLightTheme = ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    primaryColor: primaryColor,
    primaryColorLight: primaryColorLight,
    primaryColorDark: primaryColorDark,
    primarySwatch: Colors.red,
    hintColor: disabledColor,
    cardColor: whiteColor,
    dialogBackgroundColor: whiteColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        extendedSizeConstraints:
            BoxConstraints.tightFor(height: 40, width: 50)),
    textTheme: const TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
    ).apply(
      bodyColor: blackColor,
      displayColor: blackColor,
    ),
  );
}
