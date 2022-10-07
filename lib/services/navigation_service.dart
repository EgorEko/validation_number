import 'package:flutter/material.dart';

import '../navigation/app_routs_name.dart';

class NavigationService {
  void openHome(BuildContext context) {
    _pushNamed(context, homeRouteName);
  }

  void openLogin(BuildContext context) {
    _pushNamed(context, countriesRouteName);
  }

  Future<T?> _pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    debugPrint('$runtimeType: $routeName ${arguments ?? ''}');
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }
}
