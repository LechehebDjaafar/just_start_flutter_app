import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'data/just_start_data.dart';
import 'screens/main_shell.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const JustStartApp());
}

class JustStartApp extends StatefulWidget {
  const JustStartApp({super.key});

  @override
  State<JustStartApp> createState() => _JustStartAppState();
}

class _JustStartAppState extends State<JustStartApp> {
  ThemeMode _themeMode = ThemeMode.light;
  bool _showSplash = true;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appTitle,
      debugShowCheckedModeBanner: false,
      theme: JustStartTheme.lightTheme(),
      darkTheme: JustStartTheme.darkTheme(),
      themeMode: _themeMode,
      locale: const Locale('ar', 'DZ'),
      supportedLocales: const [
        Locale('ar', 'DZ'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _showSplash
            ? SplashScreen(
                key: const ValueKey('splash'),
                onFinished: () => setState(() => _showSplash = false),
              )
            : MainShell(
                key: const ValueKey('main-shell'),
                isDarkMode: _themeMode == ThemeMode.dark,
                onToggleTheme: _toggleTheme,
              ),
      ),
    );
  }
}
