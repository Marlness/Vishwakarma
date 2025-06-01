import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF9E5413); // A warm copper/bronze color for Vishwakarma
  static const Color secondaryColor = Color(0xFFEFB66E); // Lighter version for accents
  static const Color accentColor = Color(0xFF7A3803); // Darker version for emphasis
  static const Color errorColor = Color(0xFFE53935);
  static const Color successColor = Color(0xFF43A047);
  static const Color warningColor = Color(0xFFFFB300);
  static const Color infoColor = Color(0xFF2196F3);
  
  // Light theme colors
  static const Color lightBackgroundColor = Color(0xFFF5F5F5);
  static const Color lightCardColor = Colors.white;
  static const Color lightTextColor = Color(0xFF212121);
  static const Color lightSecondaryTextColor = Color(0xFF757575);
  static const Color lightDividerColor = Color(0xFFBDBDBD);
  
  // Dark theme colors
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkCardColor = Color(0xFF1E1E1E);
  static const Color darkTextColor = Color(0xFFF5F5F5);
  static const Color darkSecondaryTextColor = Color(0xFFB3B3B3);
  static const Color darkDividerColor = Color(0xFF424242);
  
  // Text styles
  static const TextStyle headingStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: lightTextColor,
  );
  
  static const TextStyle subheadingStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    color: lightTextColor,
  );
  
  static const TextStyle bodyStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
    color: lightTextColor,
  );
  
  // Button styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    textStyle: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
    ),
  );
  
  static final ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    side: const BorderSide(color: primaryColor),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    textStyle: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
    ),
  );
  
  // Light theme
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
    ),
    scaffoldBackgroundColor: lightBackgroundColor,
    cardColor: lightCardColor,
    dividerColor: lightDividerColor,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      titleMedium: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      titleSmall: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.normal),
      bodySmall: TextStyle(color: lightSecondaryTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.normal),
      labelLarge: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      labelMedium: TextStyle(color: lightTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      labelSmall: TextStyle(color: lightSecondaryTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.normal),
    ),
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: secondaryButtonStyle),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: lightDividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: lightDividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorColor),
      ),
      labelStyle: const TextStyle(
        color: lightSecondaryTextColor,
        fontFamily: 'Poppins',
      ),
      hintStyle: const TextStyle(
        color: lightSecondaryTextColor,
        fontFamily: 'Poppins',
      ),
    ),
  );
  
  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
    ),
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: darkCardColor,
    dividerColor: darkDividerColor,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      titleMedium: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      titleSmall: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.normal),
      bodySmall: TextStyle(color: darkSecondaryTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.normal),
      labelLarge: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      labelMedium: TextStyle(color: darkTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      labelSmall: TextStyle(color: darkSecondaryTextColor, fontFamily: 'Poppins', fontWeight: FontWeight.normal),
    ),
    appBarTheme: const AppBarTheme(
      color: darkCardColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
        color: darkTextColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: secondaryButtonStyle),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkCardColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: darkDividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: darkDividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorColor),
      ),
      labelStyle: const TextStyle(
        color: darkSecondaryTextColor,
        fontFamily: 'Poppins',
      ),
      hintStyle: const TextStyle(
        color: darkSecondaryTextColor,
        fontFamily: 'Poppins',
      ),
    ),
  );
}
