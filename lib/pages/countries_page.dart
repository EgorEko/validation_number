import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/load_cubit/load_cubit.dart';
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
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
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
                onChanged: (value) => context.read<LoadCubit>().search(value),
                decoration: InputDecoration(
                  prefix: IconButton(
                    onPressed: () async {
                      await context.read<LoadCubit>().searchClear();
                    },
                    icon: const Icon(Icons.search_outlined),
                  ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<LoadCubit, LoadState>(
                builder: (context, state) {
                  if (state is LoadStateSearchFounded) {
                    final items = state.countryModel;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = items[index];
                        return Card(
                          child: ListTile(
                            onTap: () {},
                            tileColor: backgroundColor,
                            title: Row(
                              children: [
                                Image.network(
                                  item.flag,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  item.root,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    color: textColor,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    color: headerColor,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is LoadStateSucceed) {
                    final items = state.countries;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = items[index];
                        return Card(
                          child: ListTile(
                            onTap: () {},
                            tileColor: backgroundColor,
                            title: Row(
                              children: [
                                Text(
                                  item.root,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    color: textColor,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    color: headerColor,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is LoadStateFailed) {
                    return Center(child: Text(state.error));
                  } else if (state is LoadStateWaiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Center(
                    child: Text('No country has been loaded'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
