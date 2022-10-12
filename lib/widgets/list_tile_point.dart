import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cubit/load_cubit/load_cubit.dart';
import '../models/country_model.dart';
import '../utils/colors.dart';

class ListTilePoint extends StatelessWidget {
  final CountryModel countryModel;

  const ListTilePoint({super.key, required this.countryModel});

  @override
  Widget build(BuildContext context) {
    final leading = SvgPicture.network(countryModel.flag);

    final title = Text(
      '${countryModel.root} ${countryModel.suffixes[0]} ${countryModel.name}',
      style: const TextStyle(
        fontFamily: 'Inter',
        color: textColor,
        fontSize: 16,
      ),
    );

    return BlocBuilder<LoadCubit, LoadState>(
      builder: (context, state) {
        return ListTile(
          onTap: () async {
            context.read<LoadCubit>().fixCountry(countryModel);
            Navigator.of(context).pop();
          },
          leading: SizedBox(height: 20, width: 38, child: leading),
          title: title,
        );
      },
    );
  }
}
