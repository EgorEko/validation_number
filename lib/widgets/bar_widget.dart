import 'package:flutter/material.dart';

import '../utils/colors.dart';

class BarWidget extends StatelessWidget {
  final String text;

  const BarWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Inter',
        color: headerColor,
        fontSize: 32,
      ),
    );
  }
}
