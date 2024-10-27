import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:go_router/go_router.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/change_password_widgets/label_feild.dart';

// import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/constants/colors.dart';

class ForgetPasswordWidgets extends StatefulWidget {
  const ForgetPasswordWidgets({super.key});

  @override
  State<ForgetPasswordWidgets> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPasswordWidgets> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.forgotPassword), // عنوان شريط التطبيق
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.qanoni,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  localizations.forgotPassword,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  localizations.restEmail,
                  style: const TextStyle(
                    fontSize: 16,
                    color: QColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: LabelFeild(text: localizations.email),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: localizations.email,
                        hintStyle: const TextStyle(color: QColors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: QColors.secondary),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSendEmailButton(localizations.sendResetEmail),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            localizations.byRequest,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // أضف الوظيفة المطلوبة هنا
                                },
                                child: Text(
                                  localizations.loginPrivacyPolicy,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: QColors.secondary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              Text(
                                localizations.loginAndText,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // أضف الوظيفة المطلوبة هنا
                                },
                                child: Text(
                                  localizations.termsOfUs,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: QColors.secondary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildSendEmailButton(String buttonText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            try {
              await _auth.sendPasswordResetEmail(email: _emailController.text);
              showToastServiceSuccess("Reset password email sent!");
              // context.go(AppRouter.kLoginView); // الانتقال إلى صفحة تسجيل الدخول
            } catch (e) {
              showToastServiceError("Error sending reset email: $e");
            }
          }
        },
        child: Text(buttonText),
      ),
    );
  }

  void showToastServiceSuccess(String message) {
    ToastService.showSuccessToast(
      context,
      length: ToastLength.medium,
      expandedHeight: 100,
      message: message,
    );
  }

  void showToastServiceError(String message) {
    ToastService.showErrorToast(
      context,
      length: ToastLength.medium,
      expandedHeight: 100,
      message: message,
    );
  }
}
