import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/validation_cubit/validation_cubit_cubit.dart';
import '../utils/colors.dart';
import 'countries_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 80,
            left: 20,
            right: 11,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 334.0,
                minWidth: 40.0,
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: headerColor,
                  fontSize: 32,
                ),
              ),
            ),
          ),
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
                SizedBox(
                  height: 48,
                  width: 256,
                  child: TextField(
                    onChanged: context.read<ValidationCubit>().activateFAB,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10),
                      TextInputFormatter.withFunction(
                        (oldValue, newValue) => _UsNumberTextInputFormatter()
                            .formatEditUpdate(oldValue, newValue),
                      )
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '(123) 123-1234',
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

class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write('${newValue.text.substring(0, usedSubstringIndex = 3)}) ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write('${newValue.text.substring(3, usedSubstringIndex = 6)}-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write('${newValue.text.substring(6, usedSubstringIndex = 10)} ');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
