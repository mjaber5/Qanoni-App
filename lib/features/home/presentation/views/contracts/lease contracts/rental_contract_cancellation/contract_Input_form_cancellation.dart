import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import localization package
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';

import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormCancellation extends StatefulWidget {
  const ContractInputFormCancellation({super.key});

  @override
  State<ContractInputFormCancellation> createState() =>
      _LeaseCancellationFormState();
}

class _LeaseCancellationFormState extends State<ContractInputFormCancellation> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController landlordNameController =
      TextEditingController(); // Landlord Name
  final TextEditingController tenantNameController =
      TextEditingController(); // Tenant Name
  final TextEditingController contractStartDateController =
      TextEditingController(); // Contract Start Date
  final TextEditingController contractEndDateController =
      TextEditingController(); // Contract End Date
  final TextEditingController cancellationReasonController =
      TextEditingController(); // Reason for Cancellation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!
            .leaseCancellationTitle), // Use localization here
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Landlord Name
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.landlordName,
                controller: landlordNameController,
                validatorMessage:
                    AppLocalizations.of(context)!.landlordNameValidator,
              ),
              const SizedBox(height: 16),

              // Tenant Name
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.tenantName,
                controller: tenantNameController,
                validatorMessage:
                    AppLocalizations.of(context)!.tenantNameValidator,
              ),
              const SizedBox(height: 16),

              // Contract Start Date
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.contractStartDate,
                controller: contractStartDateController,
                validatorMessage:
                    AppLocalizations.of(context)!.contractStartDateValidator,
              ),
              const SizedBox(height: 16),

              // Contract End Date
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.contractEndDate,
                controller: contractEndDateController,
                validatorMessage:
                    AppLocalizations.of(context)!.contractEndDateValidator,
              ),
              const SizedBox(height: 16),

              // Reason for Cancellation
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.cancellationReason,
                controller: cancellationReasonController,
                validatorMessage:
                    AppLocalizations.of(context)!.cancellationReasonValidator,
              ),
              const SizedBox(height: 32),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log('Form is valid. Proceed with contract cancellation.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .formSubmittedSuccess)),
                      );
                      GoRouter.of(context).push(AppRouter.kSuccessView);
                    } else {
                      log('Form is not valid. Show errors.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!
                        .submitButton, // Use localization here
                    style: Styles.textStyle18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build a labeled text field
  Widget buildLabeledTextField({
    required String label,
    required TextEditingController controller,
    required String validatorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Styles.textStyle18.copyWith(color: QColors.secondary),
        ),
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
