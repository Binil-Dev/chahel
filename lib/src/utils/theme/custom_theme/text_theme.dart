import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headlineMedium: GoogleFonts.poppins(
      fontSize: 32.0,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: GoogleFonts.poppins(
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: GoogleFonts.poppins(
      color: Colors.black54,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.poppins(
      color: Colors.black54,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: Colors.black54,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.poppins(
      color: Colors.black54,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: GoogleFonts.poppins(
      color: Colors.black87,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.poppins(
      color: Colors.black54,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.poppins(
      color: Colors.black54,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: GoogleFonts.poppins(
      color: Colors.black87,
      fontWeight: FontWeight.w600,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineMedium: GoogleFonts.poppins(
        fontSize: 32.0,
        color: const Color.fromARGB(255, 255, 255, 255),
        fontWeight: FontWeight.bold),
    headlineSmall:
        GoogleFonts.poppins(color: Colors.white70, fontWeight: FontWeight.w500),
    titleMedium: GoogleFonts.poppins(
        color: const Color.fromARGB(255, 239, 236, 236),
        fontWeight: FontWeight.w600),
    titleSmall:
        GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w400),
    bodyLarge:
        GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
    bodyMedium:
        GoogleFonts.poppins(color: Colors.white70, fontWeight: FontWeight.w500),
    labelLarge:
        GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
    labelMedium:
        GoogleFonts.poppins(color: Colors.white60, fontWeight: FontWeight.w500),
    labelSmall:
        GoogleFonts.poppins(color: Colors.white60, fontWeight: FontWeight.w500),
    titleLarge: GoogleFonts.poppins(
        color: const Color.fromARGB(255, 207, 203, 203),
        fontWeight: FontWeight.w600),
  );
}
