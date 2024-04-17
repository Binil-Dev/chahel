import 'package:chahel_web_1/src/features/authentication/screen/login_screen.dart';
import 'package:chahel_web_1/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: BAppTheme.lightTheme,
      darkTheme: BAppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
