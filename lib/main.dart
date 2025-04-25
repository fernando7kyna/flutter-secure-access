import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Portaria',
      theme: AppTheme.theme,
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
