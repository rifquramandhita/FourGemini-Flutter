import 'package:flutter/material.dart';
import 'package:four_gemini/app/presentation/home/home_screen.dart';
import 'package:four_gemini/config/theme/app_theme.dart';
import 'package:four_gemini/di.dart';

void main() {
  initDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(context),
      home: HomeScreen(),
    );
  }
}

