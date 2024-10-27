import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qanoni/core/utils/helpers/app_regex.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/change_password_widgets/label_feild.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';
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
        backgroundColor: Colors.transparent,
        title: Text(localizations.forgotPassword),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeaderText(localizations),
              const SizedBox(height: 14),
              _buildForm(localizations),
              const SizedBox(height: 14),
              _buildPolicyText(localizations),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.qanoni,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Text(
          localizations.forgotPassword,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          localizations.restEmail,
          style: const TextStyle(fontSize: 16, color: QColors.darkGrey),
        ),
      ],
    );
  }

  Widget _buildForm(AppLocalizations localizations) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: LabelFeild(text: localizations.email),
            ),
            const SizedBox(height: 5),
            _buildEmailField(localizations),
            const SizedBox(height: 20),
            _buildSendEmailButton(localizations.sendResetEmail),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField(AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: AppTextFormField(
        controller: _emailController,
        prefixIcon: Image.asset(
          'assets/icons/email.png',
          scale: 20,
          color: QColors.darkGrey,
        ),
        hintText: localizations.email,
        hintStyle: const TextStyle(color: QColors.darkGrey),
        validator: (value) {
          if (value == null || value.isEmpty || !AppRegex.isEmailValid(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSendEmailButton(String buttonText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
      child: ElevatedButton(
        onPressed: _sendPasswordResetEmail,
        child: Text(buttonText),
      ),
    );
  }

  Future<void> _sendPasswordResetEmail() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await _auth.sendPasswordResetEmail(email: _emailController.text);
        _showToastSuccess("Reset password email sent!");
      } catch (e) {
        _showToastError("Error sending reset email: $e");
      }
    }
  }

  Widget _buildPolicyText(AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              localizations.byRequest,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 4),
            _buildPolicyLinks(localizations),
          ],
        ),
      ),
    );
  }

  Row _buildPolicyLinks(AppLocalizations localizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPolicyLink(
          onTap: () {},
          text: localizations.loginPrivacyPolicy,
        ),
        Text(
          ' ${localizations.loginAndText} ',
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        _buildPolicyLink(
          onTap: () {},
          text: localizations.termsOfUs,
        ),
      ],
    );
  }

  GestureDetector _buildPolicyLink(
      {required VoidCallback onTap, required String text}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: QColors.secondary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  void _showToastSuccess(String message) {
    ToastService.showSuccessToast(
      context,
      length: ToastLength.medium,
      expandedHeight: 100,
      message: message,
    );
  }

  void _showToastError(String message) {
    ToastService.showErrorToast(
      context,
      length: ToastLength.medium,
      expandedHeight: 100,
      message: message,
    );
  }
}
