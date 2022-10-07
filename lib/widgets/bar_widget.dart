import 'package:flutter/material.dart';

import '../utils/colors.dart';

class BarWidget extends StatelessWidget {
  const BarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      left: 20,
      right: 11,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 334.0,
          minWidth: 40.0,
        ),
        child: const Text(
          'Get Started',
          style: TextStyle(
            fontFamily: 'Inter',
            color: headerColor,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
