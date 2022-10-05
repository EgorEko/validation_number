import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class ValidationPoneApp extends StatelessWidget {
  const ValidationPoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
