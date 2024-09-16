import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/helpers/app_regex.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';
import 'package:qanoni/features/authentication/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:qanoni/features/authentication/signup/presentation/views/signup_widgets/signup_password_condition_stronger.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';
import 'package:user_repository/user_reposetory.dart';

class SignupTextFeilds extends StatefulWidget {
  const SignupTextFeilds({super.key});

  @override
  State<SignupTextFeilds> createState() => _SignupTextFeildsState();
}

class _SignupTextFeildsState extends State<SignupTextFeilds> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordObscureText = true;
  bool isPasswordConfirmationObscureText = true;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  bool signUpRequired = false;

  late TextEditingController passwordController;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    setupPasswordControllerListener();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters =
            AppRegex.hasSpecialCharacter(passwordController.text);
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: BlocListener<SignUpBloc, SignUpBlocState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            setState(() {
              signUpRequired = false;
            });
            GoRouter.of(context).pushReplacement(AppRouter.kLayout);

            ToastService.showSuccessToast(
              context,
              length: ToastLength.medium,
              expandedHeight: 100,
              message: "Create account sucess!",
            );
          } else if (state is SignUpProcess) {
            setState(() {
              signUpRequired = true;
            });
          } else if (state is SignUpFailure) {
            ToastService.showWarningToast(
              context,
              length: ToastLength.medium,
              expandedHeight: 100,
              message: "Something went wrong!",
            );
            return;
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextFormField(
                controller: nameController,
                hintText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    ToastService.showErrorToast(
                      context,
                      length: ToastLength.medium,
                      expandedHeight: 100,
                      message: "Name wrong !",
                    );
                    return 'Please enter a valid name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: phoneController,
                hintText: 'Phone number',
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isPhoneNumberValid(value)) {
                    ToastService.showErrorToast(
                      context,
                      length: ToastLength.medium,
                      expandedHeight: 100,
                      message: "Phone number wrong !",
                    );
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isEmailValid(value)) {
                    ToastService.showErrorToast(
                      context,
                      length: ToastLength.medium,
                      expandedHeight: 100,
                      message: "Email wrong !",
                    );
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: passwordController,
                hintText: 'Password',
                isObscureText: isPasswordObscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordObscureText = !isPasswordObscureText;
                    });
                  },
                  child: Icon(
                    isPasswordObscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    ToastService.showErrorToast(
                      context,
                      length: ToastLength.medium,
                      expandedHeight: 100,
                      message: "Password wrong !",
                    );
                    return 'Please enter a valid password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: passwordConfirmationController,
                hintText: 'Password Confirmation',
                isObscureText: isPasswordConfirmationObscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordConfirmationObscureText =
                          !isPasswordConfirmationObscureText;
                    });
                  },
                  child: Icon(
                    isPasswordConfirmationObscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    ToastService.showWarningToast(
                      context,
                      length: ToastLength.medium,
                      expandedHeight: 100,
                      message: "confirm your password !",
                    );
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    ToastService.showErrorToast(
                      context,
                      length: ToastLength.medium,
                      expandedHeight: 100,
                      message: "confirm password wrong !",
                    );
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SignupPasswordValidations(
                hasLowerCase: hasLowercase,
                hasUpperCase: hasUppercase,
                hasSpecialCharacters: hasSpecialCharacters,
                hasNumber: hasNumber,
                hasMinLength: hasMinLength,
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
                      MyUsers myUser = MyUsers.empty;
                      myUser = myUser.copyWith(
                        email: emailController.text,
                        userName: nameController.text,
                        phone: phoneController.text,
                        confirmPassword: passwordConfirmationController.text,
                      );
                      setState(() {
                        context.read<SignUpBloc>().add(
                              SignUpRequired(
                                myUser,
                                passwordController.text,
                              ),
                            );
                      });
                      log('Form is valid. Proceed with signup.');
                    } else {
                      log('Form is not valid. Show errors.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: const Text(
                    QTexts.signupTitleView,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
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
