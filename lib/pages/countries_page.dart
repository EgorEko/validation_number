import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/api_cubit/api_cubit.dart';

class CountriesPage extends StatelessWidget {
  const CountriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiCubit, ApiState>(
      builder: (context, state) {
        if (state is ApiStateInitial) {
          context.read<ApiCubit>().load();
        } else if (state is ApiStateSucceed) {
          final items = state.countries;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  tileColor: Colors.greenAccent.shade700,
                  title: Text(
                    '${item.code}',
                  ),
                  subtitle: Text(
                    item.name,
                  ),
                ),
              );
            },
          );
        } else if (state is ApiStateFailed) {
          return Center(child: Text(state.error));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
