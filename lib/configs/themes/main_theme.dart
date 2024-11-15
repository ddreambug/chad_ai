import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData mainTheme = ThemeData(
  primaryColor: MainColor.primary,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: MainColor.primary,
    cardColor: MainColor.white,
    errorColor: MainColor.danger,
  ),
  iconTheme: IconThemeData(
    color: MainColor.primary,
    size: 24.sp,
  ),
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    bodyMedium:
        GoogleFonts.roboto(color: MainColor.black, fontWeight: FontWeight.w600),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStatePropertyAll(5),
      foregroundColor: WidgetStatePropertyAll(MainColor.white),
      backgroundColor: WidgetStatePropertyAll(MainColor.primary),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(fontSize: 14.sp),
    hintStyle: TextStyle(color: MainColor.grey, fontSize: 12.sp),
  ),
  dividerTheme: const DividerThemeData(
    color: Color.fromARGB(92, 51, 51, 51),
    thickness: 0.5,
  ),
);
