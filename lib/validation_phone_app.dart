import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'utils/colors.dart';

class ValidationPoneApp extends StatelessWidget {
  const ValidationPoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Inter',
      ),
      home: const HomePage(),
    );
  }
}
