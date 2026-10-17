import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// الهوية البصرية الرسمية لتطبيق Just Start - إبدأ الآن
/// مستوحاة من شعار البومة وتصاميم المنشورات:
/// البنفسجي الملكي (#6D28D9) + الأزرق الكهربائي (#0099FF) + الكحلي الليلي (#0F172A)
class JustStartTheme {
  static const Color royalViolet = Color(0xFF6D28D9);
  static const Color deepViolet = Color(0xFF4C1D95);
  static const Color electricBlue = Color(0xFF0099FF);
  static const Color royalBlue = Color(0xFF2563EB);
  static const Color midnightNavy = Color(0xFF0F172A);
  static const Color darkSlate = Color(0xFF1E293B);
  static const Color mutedSlate = Color(0xFF64748B);

  static const Color lightCanvas = Color(0xFFF8FAFC);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightSubtle = Color(0xFFEEF2FF);
  static const Color darkCanvas = Color(0xFF0B0F19);
  static const Color darkCard = Color(0xFF161F33);
  static const Color darkSubtle = Color(0xFF1E293B);

  static const Color whatsappGreen = Color(0xFF25D366);
  static const Color emeraldBadge = Color(0xFF10B981);
  static const Color facebookBlue = Color(0xFF1877F2);
  static const Color emailRed = Color(0xFFEA4335);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [royalViolet, electricBlue],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const LinearGradient darkStageGradient = LinearGradient(
    colors: [Color(0xFF1E1B4B), Color(0xFF0F172A), Color(0xFF0C4A6E)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static ThemeData lightTheme() {
    final baseText = GoogleFonts.ibmPlexSansArabicTextTheme();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightCanvas,
      primaryColor: royalViolet,
      colorScheme: const ColorScheme.light(
        primary: royalViolet,
        secondary: electricBlue,
        tertiary: emeraldBadge,
        surface: lightCard,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: midnightNavy,
      ),
      textTheme: baseText.apply(
        bodyColor: midnightNavy,
        displayColor: midnightNavy,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: midnightNavy,
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        color: lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: royalViolet, width: 1.8),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    final baseText = GoogleFonts.ibmPlexSansArabicTextTheme(
      ThemeData.dark().textTheme,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkCanvas,
      primaryColor: royalViolet,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF8B5CF6),
        secondary: electricBlue,
        tertiary: emeraldBadge,
        surface: darkCard,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFFF8FAFC),
      ),
      textTheme: baseText.apply(
        bodyColor: const Color(0xFFF1F5F9),
        displayColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0F172A),
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF1E293B), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF0F172A),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1E293B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: electricBlue, width: 1.8),
        ),
      ),
    );
  }
}
