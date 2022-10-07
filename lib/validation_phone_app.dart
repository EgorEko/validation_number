import 'package:flutter/material.dart';

import 'navigation/app_routs_name.dart';
import 'pages/countries_page.dart';
import 'pages/home_page.dart';
import 'utils/colors.dart';

class ValidationPhoneApp extends StatelessWidget {
  final String initialRoute;

  const ValidationPhoneApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Inter',
      ),
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        if (settings.name == countriesRouteName) {
          return MaterialPageRoute(builder: (context) => const CountriesPage());
        }
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      },
      routes: {'/countries': (BuildContext context) => const CountriesPage()},
    );
  }
}
