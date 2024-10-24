// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

import '../../../../../../core/widgets/app_text_form_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordSectionState();
}

class _ChangePasswordSectionState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isObscureTextCurrent = true;
  bool isObscureTextNew = true;
  bool isObscureTextConfirm = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10, 
        top: 10
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Label for Current Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                localizations.currentPassword, // "Current Password"
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            // Current Password Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppTextFormField(
                controller: currentPasswordController,
                prefixIcon: Image.asset(
                  'assets/icons/password-icon.png',
                  scale: 20,
                  color: Colors.grey[700],
                ),
                hintText: localizations.currentPassword,
                isObscureText: isObscureTextCurrent,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureTextCurrent = !isObscureTextCurrent;
                    });
                  },
                  child: Icon(
                    isObscureTextCurrent
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            
            // Label for New Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                localizations.newPassword, // "New Password"
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            // New Password Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppTextFormField(
                controller: newPasswordController,
                prefixIcon: Image.asset(
                  'assets/icons/password-icon.png',
                  scale: 20,
                  color: Colors.grey[700],
                ),
                hintText: localizations.newPassword,
                isObscureText: isObscureTextNew,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureTextNew = !isObscureTextNew;
                    });
                  },
                  child: Icon(
                    isObscureTextNew
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            
            // Label for Confirm New Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                localizations.confirmPassword, // "Confirm New Password"
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            // Confirm New Password Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppTextFormField(
                controller: confirmPasswordController,
                prefixIcon: Image.asset(
                  'assets/icons/password-icon.png',
                  scale: 20,
                  color: Colors.grey[700],
                ),
                hintText: localizations.confirmPassword,
                isObscureText: isObscureTextConfirm,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureTextConfirm = !isObscureTextConfirm;
                    });
                  },
                  child: Icon(
                    isObscureTextConfirm
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  } else if (value != newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            
            // Change Password Button
            Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
                top: 16,
                left: 8,
                right: 8,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _changePassword(
                      currentPasswordController.text,
                      newPasswordController.text,
                    );
                  }
                  context.go(AppRouter.kSettingsView);

                },
                child: Text(localizations.changePassword),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changePassword(
  String currentPassword, String newPassword) async {
  try {
    User? user = _auth.currentUser;

    // Reauthenticate the user with the current password
    final cred = EmailAuthProvider.credential(
      email: user!.email!,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(cred);

    // If reauthentication is successful, update the password
    await user.updatePassword(newPassword);

    // Show success toast
    ToastService.showSuccessToast(
      context,
      length: ToastLength.medium,
      expandedHeight: 100,
      message: "Password changed successfully!",
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'wrong-password') {
      ToastService.showErrorToast(
        context,
        length: ToastLength.medium,
        expandedHeight: 100,
        message: "The current password is incorrect.",
      );
    } else {
      ToastService.showErrorToast(
        context,
        length: ToastLength.medium,
        expandedHeight: 100,
        message: (e.message ?? "An error occurred."),
      );
    }
  } catch (e) {
    ToastService.showErrorToast(
      context,
      length: ToastLength.medium,
      expandedHeight: 100,
      message: "An error occurred. Please try again.",
    );
  }
}
}