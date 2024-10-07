import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/helpers/app_regex.dart';
import '../../../../../../core/widgets/app_text_form_field.dart';
import '../../view_model/sign_in_bloc/signin_bloc.dart';
import 'login_button.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginInputsSection extends StatefulWidget {
  const LoginInputsSection({super.key});

  @override
  State<LoginInputsSection> createState() => _LoginInputsSectionState();
}

class _LoginInputsSectionState extends State<LoginInputsSection> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool signInRequired = false;
  String? errorMsg;
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: BlocListener<SigninBloc, SigninState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            setState(() {
              signInRequired = false;
            });
            GoRouter.of(context).pushReplacement(AppRouter.kLayout);
            ToastService.showSuccessToast(
              context,
              length: ToastLength.medium,
              expandedHeight: 100,
              message: "Login Success",
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
            ToastService.showWarningToast(
              context,
              length: ToastLength.medium,
              expandedHeight: 100,
              message: "Something went wrong!",
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
                hintText: localizations.email,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isEmailValid(value)) {
                    ToastService.showErrorToast(
                      context,
                      length: ToastLength.medium,
                      expandedHeight: 100,
                      message: "email wrong enter!",
                    );
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: passwordController,
                hintText: localizations.password,
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
                    ToastService.showErrorToast(
                      context,
                      length: ToastLength.medium,
                      expandedHeight: 100,
                      message: "password wrong enter!",
                    );
                    return 'Please enter a valid password';
                  }
                  return null;
                },
              ),
              LoginButton(
                formKey: _formKey,
                emailController: emailController,
                passwordController: passwordController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
