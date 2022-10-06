import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../cubit/validation_cubit/validation_cubit_cubit.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _numberController = TextEditingController();

  final String initialCountry = 'US';

  PhoneNumber number = PhoneNumber(isoCode: 'US');

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
            child: Form(
              key: formKey,
              child: BlocBuilder<ValidationCubit, ValidationState>(
                builder: (context, state) {
                  return InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      print(number.phoneNumber);
                    },
                    inputDecoration: InputDecoration(
                      fillColor: fieldsBackgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    hintText: '(123)123-1234',
                    autoValidateMode: AutovalidateMode.disabled,
                    textStyle: const TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                    initialValue: number,
                    textFieldController: _numberController,
                    formatInput: true,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    inputBorder: const OutlineInputBorder(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:
          BlocSelector<ValidationCubit, ValidationState, bool>(
        selector: (state) {
          return state is ValidationStateSucceeded;
        },
        builder: (context, state) {
          return FloatingActionButton(
            backgroundColor: fabActiveColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            onPressed: state
                ? () {
                    print('active');
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

  void getPhoneNumber(String phoneNumber) async {
    String phoneNumber = '+1(123)123-1234';
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');
    String parsableNumber = number.parseNumber();

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }
}
