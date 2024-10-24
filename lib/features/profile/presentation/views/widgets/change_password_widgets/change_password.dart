import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/change_password_widgets/label_feild.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/change_password_widgets/password_feilds.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isObscureTextCurrent = true;
  bool _isObscureTextNew = true;
  bool _isObscureTextConfirm = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LabelFeild(text: localizations.currentPassword),
            PasswordFeild(
                controller: _currentPasswordController,
                hintText: localizations.currentPassword,
                isObscureText: _isObscureTextCurrent,
                toggleObscureText: () {
                  setState(() {
                    _isObscureTextCurrent = !_isObscureTextCurrent;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                }),
            const SizedBox(height: 20),
            LabelFeild(text: localizations.newPassword),
            PasswordFeild(
                controller: _newPasswordController,
                hintText: localizations.newPassword,
                isObscureText: _isObscureTextNew,
                toggleObscureText: () {
                  setState(() {
                    _isObscureTextNew = !_isObscureTextNew;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  return null;
                }),
            const SizedBox(height: 20),
            LabelFeild(text: localizations.confirmPassword),
            PasswordFeild(
                controller: _confirmPasswordController,
                hintText: localizations.confirmPassword,
                isObscureText: _isObscureTextConfirm,
                toggleObscureText: () {
                  setState(() {
                    _isObscureTextConfirm = !_isObscureTextConfirm;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  } else if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                }),
            const SizedBox(height: 20),
            _buildChangePasswordButton(localizations.changePassword),
          ],
        ),
      ),
    );
  }

  Padding _buildChangePasswordButton(String buttonText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await (String currentPassword, String newPassword) async {
              try {
                User? user = _auth.currentUser;
                if (user != null) {
                  final cred = EmailAuthProvider.credential(
                    email: user.email!,
                    password: currentPassword,
                  );
                  await user.reauthenticateWithCredential(cred);
                  await user.updatePassword(newPassword);

                  showToastServiceSuccess("Password changed successfully!");
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'wrong-password') {
                  showToastServiceError("The current password is incorrect.");
                } else {
                  showToastServiceError(e.message ?? "An error occurred.");
                }
              } catch (_) {
                showToastServiceError("An error occurred. Please try again.");
              }
            }(
              _currentPasswordController.text,
              _newPasswordController.text,
            );
            context.go(AppRouter.kSettingsView);
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

  void showToastServiceWrong(String message) {
    ToastService.showWarningToast(
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
