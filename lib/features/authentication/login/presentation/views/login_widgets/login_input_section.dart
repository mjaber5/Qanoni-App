import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/features/authentication/login/presentation/views/login_widgets/login_button.dart';
import 'package:qanoni/features/authentication/login/presentation/views/login_widgets/remember_me_check_box.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/helpers/app_regex.dart';
import '../../../../../../core/widgets/app_text_form_field.dart';
import '../../view_model/sign_in_bloc/signin_bloc.dart';
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
              message: errorMsg,
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppTextFormField(
                  controller: emailController,
                  prefixIcon: Image.asset(
                    'assets/icons/email.png',
                    scale: 20,
                    color: QColors.white,
                  ),
                  hintText: localizations.email,
                  hintStyle: const TextStyle(color: QColors.white),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !AppRegex.isEmailValid(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppTextFormField(
                  controller: passwordController,
                  prefixIcon: Image.asset(
                    'assets/icons/password-icon.png',
                    scale: 20,
                    color: QColors.white,
                  ),
                  hintText: localizations.password,
                  hintStyle: const TextStyle(color: QColors.white),
                  isObscureText: isObscureText,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    child: Icon(
                      color: QColors.white,
                      isObscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                ),
              ),
              const Row(
                children: [
                  LoginActionText(),
                ],
              ),
              LoginButton(
                formKey: _formKey,
                emailController: emailController,
                passwordController: passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
