import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_colors.dart';

class AppThemes {
  const AppThemes._();

  static ThemeData light = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.deepbleu,
      ),
      titleMedium: GoogleFonts.lato(
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.grey,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    ),
  );

  static ThemeData dark = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.lato(
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.lightblack,
    ),
    cardColor: AppColors.lightblack,
    scaffoldBackgroundColor: AppColors.black,
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
