import 'theme/app_theme.dart';
import 'screens/main_shell.dart';
import 'package:flutter/material.dart';

class GlDashcamApp extends StatelessWidget {
  const GlDashcamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GL Dashcam',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainShell(),
    );
  }
}
