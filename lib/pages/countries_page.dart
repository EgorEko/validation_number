import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/api_cubit/api_cubit.dart';
import '../utils/colors.dart';
import '../widgets/bar_widget.dart';

class CountriesPage extends StatelessWidget {
  const CountriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                ),
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(minWidth: 295, minHeight: 40),
                  child: const BarWidget(
                    text: 'Country code',
                  ),
                ),
              ),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 48,
              child: TextField(
                decoration: InputDecoration(
                  prefix: const Icon(Icons.search_outlined),
                  hintText: 'Search',
                  filled: true,
                  fillColor: fieldsBackgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ApiCubit, ApiState>(
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
                          tileColor: backgroundColor,
                          title: Text(
                            item.root,
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
            ),
          ),
        ],
      ),
    );
  }
}
