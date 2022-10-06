import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/validation_cubit/validation_cubit_cubit.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _numberController = TextEditingController();
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
                    onPressed: () {},
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
                  child: BlocBuilder<ValidationCubit, ValidationState>(
                    builder: (context, state) {
                      if (state is ValidationStateInitial) {
                        return TextField(
                          controller: _numberController,
                          autofocus: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
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
                          onChanged: ((value) => context
                              .read<ValidationCubit>()
                              .validatePhoneNumber(value)),
                        );
                      }
                      if (state is ValidationStateInProcess) {
                        return TextField(
                          controller: _numberController,
                          autofocus: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
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
                          onChanged: ((value) => context
                              .read<ValidationCubit>()
                              .validatePhoneNumber(value)),
                        );
                      }
                      if (state is ValidationStateSucceeded) {
                        return TextField(
                          controller: _numberController,
                          autofocus: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
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
                          onChanged: ((value) => context
                              .read<ValidationCubit>()
                              .validatePhoneNumber(value)),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
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
}
