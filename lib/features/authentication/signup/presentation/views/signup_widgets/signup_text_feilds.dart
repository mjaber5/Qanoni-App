import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/helpers/app_regex.dart';
import '../../../../../../core/widgets/app_text_form_field.dart';
import '../../view_model/sign_up_bloc/sign_up_bloc.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';
import 'package:user_repository/user_reposetory.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupTextFeilds extends StatefulWidget {
  const SignupTextFeilds({super.key});

  @override
  State<SignupTextFeilds> createState() => _SignupTextFeildsState();
}

class _SignupTextFeildsState extends State<SignupTextFeilds> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordObscureText = true;
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
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 12),
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
                prefixIcon: Image.asset(
                  'assets/icons/user.png',
                  scale: 20,
                  color: Colors.grey[700],
                ),
                hintText: localizations.userName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: phoneController,
                prefixIcon: Image.asset(
                  'assets/icons/telephone.png',
                  scale: 20,
                  color: Colors.grey[700],
                ),
                hintText: localizations.phone,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isPhoneNumberValid(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: emailController,
                prefixIcon: Image.asset(
                  'assets/icons/email.png',
                  scale: 20,
                  color: Colors.grey[700],
                ),
                hintText: localizations.email,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isEmailValid(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: passwordController,
                prefixIcon: Image.asset(
                  'assets/icons/password-icon.png',
                  scale: 20,
                  color: Colors.grey[700],
                ),
                hintText: localizations.password,
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
                    return 'Please enter a valid password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                  top: 16,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      MyUsers myUser = MyUsers.empty;
                      myUser = myUser.copyWith(
                        email: emailController.text,
                        userName: nameController.text,
                        phone: phoneController.text,
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
                      ToastService.showErrorToast(
                        context,
                        length: ToastLength.medium,
                        expandedHeight: 100,
                        message: "Please fill fields!",
                      );
                      log('Form is not valid. Show errors.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: Text(
                    localizations.createAccount,
                    style: const TextStyle(
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
