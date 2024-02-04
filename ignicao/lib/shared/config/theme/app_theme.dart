import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          tertiary: AppColors.labelTitle,
          background: AppColors.background,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appBarColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: AppColors.primary,
          ),
          titleTextStyle: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            fontSize: 30,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
        ),
        canvasColor: AppColors.background,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          labelMedium: TextStyle(
            color: AppColors.labelTitle,
            fontSize: 20,
          ),
          bodySmall: TextStyle(
            color: AppColors.labelWhite,
            fontSize: 12,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 60,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: AppColors.primary,
          ),
          titleSmall: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppColors.labelTitle,
          ),
          headlineLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppColors.labelTitle,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          textTheme: ButtonTextTheme.primary,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        cardTheme: const CardTheme(
          color: AppColors.cardBackground,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        dialogTheme: const DialogTheme(
          alignment: Alignment.center,
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          },
        ),
      );
}
