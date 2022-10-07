import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Stack(
        children: <Widget>[
          const BarWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 280, left: 20, right: 20),
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
                        context: context,
                        builder: (context) {
                          return const CountriesPage();
                        },
                      );
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            height: 20,
                            width: 28,
                            'https://media.istockphoto.com/photos/united-states-of-america-national-fabric-flag-textile-background-of-picture-id1174981237?k=20&m=1174981237&s=612x612&w=0&h=FIUIiqlm9ttScAfBCZJKTxJyTfgHQYk2sG7g_46_8dk=',
                          ),
                        ),
                        const Text(
                          '+1',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
