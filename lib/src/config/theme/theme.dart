import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udevs_tz/src/core/colors/colors.dart';

abstract class AppTheme {
  static ThemeData lighTheme() => ThemeData(
        scaffoldBackgroundColor: AppColors.C_FFFFFF,
        appBarTheme: const AppBarTheme(
          toolbarHeight: 0.0,
          elevation: 0.0,
          backgroundColor: AppColors.C_FFFFFF,
          iconTheme: IconThemeData(
            color: AppColors.C_292929,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: AppColors.C_FFFFFF,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontSize: 12.0,
            color: AppColors.C_292929,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w400,
          ),
          displayMedium: TextStyle(
            fontSize: 14.0,
            color: AppColors.C_292929,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}
