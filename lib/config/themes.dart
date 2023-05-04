import 'package:flutter/material.dart';

dynamic kPrimaryColor = Colors.red;

class PresmaflixThemes {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: kPrimaryColor,
    primaryColor: kPrimaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      background: const Color(0xffF3F2EF),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xffF3F2EF),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: kPrimaryColor,
    primaryColor: kPrimaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      background: const Color(0xff131313),
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xff131313),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
    ),    
  );
}
