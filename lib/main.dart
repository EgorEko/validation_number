import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'cubit/validation_cubit/validation_cubit_cubit.dart';
import 'validation_phone_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => ValidationCubit(),
        ),
      ],
      child: const ValidationPoneApp(),
    ),
  );
}
