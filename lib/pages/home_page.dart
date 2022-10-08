import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cubit/load_cubit/load_cubit.dart';
import '../cubit/validation_cubit/validation_cubit_cubit.dart';
import '../utils/colors.dart';
import '../widgets/bar_widget.dart';
import '../widgets/field_number_widget.dart';
import 'countries_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 20),
            child: Row(
              children: [
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(minWidth: 344, minHeight: 40),
                  child: const BarWidget(
                    text: 'Get Started',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 160, left: 20, right: 20),
            child: Row(
              children: [
                SizedBox(
                  height: 48,
                  width: 71,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        fieldsBackgroundColor,
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: backgroundColor,
                        context: context,
                        builder: (context) {
                          return const CountriesPage();
                        },
                      );
                    },
                    child: BlocBuilder<LoadCubit, LoadState>(
                      builder: (context, state) {
                        String flag = 'https://flagcdn.com/us.svg';
                        String root = '+1';
                        if (state is LoadStateFixedCountry) {
                          flag = state.countryModel.flag;
                          root = state.countryModel.root;
                        }

                        return Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SvgPicture.network(
                                flag,
                                width: 32,
                              ),
                            ),
                            Text(
                              root,
                              style: const TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const FieldNumberWidget()
              ],
            ),
          )
        ],
      ),
      floatingActionButton:
          BlocSelector<ValidationCubit, ValidationState, bool>(
        selector: (state) {
          if (state is ValidationStateSucceeded) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          return FloatingActionButton(
            backgroundColor: state ? fabActiveColor : fabNotActiveColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            onPressed: state
                ? () {
                    debugPrint('button is active');
                  }
                : null,
            child: const Icon(
              Icons.arrow_forward,
              color: textColor,
            ),
          );
        },
      ),
    );
  }
}
