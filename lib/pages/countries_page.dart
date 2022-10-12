import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/load_cubit/load_cubit.dart';
import '../services/app_injectable.dart';
import '../utils/colors.dart';
import '../widgets/bar_widget.dart';
import '../widgets/list_tile_point.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoadCubit, LoadState>(
      listener: (context, state) {
        if (state is LoadStateFixedCountry) {
          context.navigationService.openHome(context);
        }
      },
      child: Scaffold(
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
                    context.read<LoadCubit>().searchClear();
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
                      onPressed: () {},
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
              child: BlocBuilder<LoadCubit, LoadState>(
                builder: (context, state) {
                  if (state is LoadStateSearchFounded) {
                    final items = state.countryModel;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = items[index];
                        return ListTilePoint(countryModel: item);
                      },
                    );
                  }
                  if (state is LoadStateSucceed) {
                    final items = state.countries;
                    return ListView.builder(
                      itemCount: items.length,
                      prototypeItem: ListTile(
                        title: Text(items.first.name),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final item = items[index];

                        return ListTilePoint(countryModel: item);
                      },
                    );
                  } else if (state is LoadStateFailed) {
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
      ),
    );
  }
}
