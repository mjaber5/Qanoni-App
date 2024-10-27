import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // تأكد من استيراد AppLocalizations
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';

import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormArgeement extends StatefulWidget {
  const ContractInputFormArgeement({super.key});

  @override
  State<ContractInputFormArgeement> createState() => _ContractInputFormState();
}

class _ContractInputFormState extends State<ContractInputFormArgeement> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController projectOwnerNameController =
      TextEditingController();
  final TextEditingController projectOwnerIdController =
      TextEditingController();
  final TextEditingController contractorNameController =
      TextEditingController();
  final TextEditingController contractorIdController = TextEditingController();
  final TextEditingController contractDurationController =
      TextEditingController();
  final TextEditingController contractValueController = TextEditingController();
  final TextEditingController materialsProvidedController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.contractInputTitle),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildLabeledTextField(
                label: localizations.projectNameLabel,
                controller: projectNameController,
                validatorMessage: localizations.projectNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.projectOwnerNameLabel,
                controller: projectOwnerNameController,
                validatorMessage: localizations.projectOwnerNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.projectOwnerIdLabel,
                controller: projectOwnerIdController,
                validatorMessage: localizations.projectOwnerIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.contractorNameLabel,
                controller: contractorNameController,
                validatorMessage: localizations.contractorNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.contractorIdLabel,
                controller: contractorIdController,
                validatorMessage: localizations.contractorIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.contractDurationLabel,
                controller: contractDurationController,
                validatorMessage: localizations.contractDurationValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.contractValueLabel,
                controller: contractValueController,
                validatorMessage: localizations.contractValueValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.materialsProvidedLabel,
                controller: materialsProvidedController,
                validatorMessage: localizations.materialsProvidedValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.startDateLabel,
                controller: startDateController,
                validatorMessage: localizations.startDateValidation,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log(localizations.successMessage);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(localizations.successMessage)),
                      );
                      GoRouter.of(context).push(AppRouter.kSuccessView);
                    } else {
                      log(localizations.errorMessage);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child:
                      Text(localizations.saveButton, style: Styles.textStyle18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabeledTextField({
    required String label,
    required TextEditingController controller,
    required String validatorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Styles.textStyle18.copyWith(color: QColors.secondary)),
        const SizedBox(height: 8),
        AppTextFormField(
          controller: controller,
          hintText: label,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validatorMessage;
            }
            return null;
          },
        ),
      ],
    );
  }
}
