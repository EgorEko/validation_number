import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation_service.dart';

extension BuildContextX on BuildContext {
  NavigationService get navigationService => read<NavigationService>();
}
