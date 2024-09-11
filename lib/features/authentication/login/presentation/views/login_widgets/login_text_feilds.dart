import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';

import 'package:qanoni/core/utils/helpers/app_regex.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';
import 'package:qanoni/features/authentication/blocs/sign_in_bloc/signin_bloc.dart';

class LoginTextFeilds extends StatefulWidget {
  const LoginTextFeilds({super.key});

  @override
  State<LoginTextFeilds> createState() => _LoginTextFeildsState();
}

class _LoginTextFeildsState extends State<LoginTextFeilds> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool isObscureText = true;
  bool signInRequired = false;
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: BlocListener<SigninBloc, SigninState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            setState(() {
              signInRequired = false;
            });
            GoRouter.of(context).pushReplacement(AppRouter.kLayout);
            Fluttertoast.showToast(
              msg: '✓ Login Succeeded',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: QColors.darkerGrey,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else if (state is SignInProcess) {
            setState(() {
              signInRequired = true;
            });
          } else if (state is SignInFailure) {
            setState(() {
              signInRequired = false;
              errorMsg = 'Invalid email or password';
            });
            Fluttertoast.showToast(
              msg: 'Something wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: QColors.darkerGrey,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextFormField(
                controller: emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isEmailValid(value)) {
                    return 'Please enter a valid email';
                  }
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: passwordController,
                hintText: 'Password',
                isObscureText: isObscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  child: Icon(
                    isObscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                  top: 16,
                  left: 18,
                  right: 18,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SigninBloc>().add(
                            SignInRequired(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                      log('Form is valid. Proceed with login.');
                    } else {
                      log('Form is not valid. Show errors.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: const Text(
                    QTexts.loginButton,
                    style: Styles.textStyle18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
