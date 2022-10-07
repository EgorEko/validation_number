import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'cubit/load_cubit/load_cubit.dart';
import 'cubit/validation_cubit/validation_cubit_cubit.dart';
import 'navigation/app_routs_name.dart';
import 'services/api/api_service.dart';
import 'validation_phone_app.dart';

void main() {
  final apiService = ApiService(baseUrl: 'restcountries.com');

  const String initialRoute = homeRouteName;
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>.value(value: apiService),
        BlocProvider(
          create: (_) => ValidationCubit(),
        ),
        BlocProvider(
          create: (_) => LoadCubit(apiService),
        ),
      ],
      child: BlocBuilder<ValidationCubit, ValidationState>(
        builder: (context, state) {
          return const ValidationPhoneApp(
            initialRoute: initialRoute,
          );
        },
      ),
    ),
  );
}
