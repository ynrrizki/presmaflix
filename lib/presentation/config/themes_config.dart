import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

dynamic kPrimaryColor = Colors.red;

class PresmaflixThemes {
  // light
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
  // dark
  static final ThemeData darkTheme = ThemeData(
    // useMaterial3: true,
    primarySwatch: kPrimaryColor,
    primaryColor: kPrimaryColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.red,
    ),
    primaryTextTheme: const TextTheme(
      bodyLarge: TextStyle(),
      bodyMedium: TextStyle(),
      bodySmall: TextStyle(),
    ).apply(
      bodyColor: Colors.white,
      displayColor: Colors.grey,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.grey,
      ),
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
      shadowColor: Colors.grey,
      elevation: 0.5,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white,
    ),
    useMaterial3: true,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),
    cardTheme: const CardTheme(
      color: Color(0xff131313),
      elevation: 0,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      dividerColor: Colors.black,
    ),
    dialogTheme: DialogTheme(
      iconColor: Colors.white,
      titleTextStyle: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(),
      bodyMedium: TextStyle(),
      bodySmall: TextStyle(),
    ).apply(
      bodyColor: Colors.white,
      displayColor: Colors.grey,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xff131313),
      dragHandleColor: Colors.grey,
    ),
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
