import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // تأكد من إضافة هذه المكتبة للوصول إلى ملفات الترجمة
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormDailyWork extends StatefulWidget {
  const ContractInputFormDailyWork({super.key});

  @override
  State<ContractInputFormDailyWork> createState() =>
      _DailyContractInputFormState();
}

class _DailyContractInputFormState extends State<ContractInputFormDailyWork> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController firstPartyNameController = TextEditingController();
  final TextEditingController firstPartyIdController = TextEditingController();
  final TextEditingController firstPartyAddressController = TextEditingController();
  final TextEditingController firstPartyPhoneController = TextEditingController();
  final TextEditingController secondPartyNameController = TextEditingController();
  final TextEditingController secondPartyIdController = TextEditingController();
  final TextEditingController secondPartyNationalityController = TextEditingController();
  final TextEditingController secondPartyAddressController = TextEditingController();
  final TextEditingController secondPartyPhoneController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController contractStartDateController = TextEditingController();
  final TextEditingController dailyWageController = TextEditingController();
  final TextEditingController workingHoursController = TextEditingController();
  final TextEditingController breakDurationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // للحصول على الكائن الخاص بالترجمة

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
              // First Party Name
              buildLabeledTextField(
                label: localizations.firstPartyNameLabel,
                controller: firstPartyNameController,
                validatorMessage: localizations.firstPartyNameValidation,
              ),
              const SizedBox(height: 16),

              // First Party ID / Commercial Record
              buildLabeledTextField(
                label: localizations.firstPartyIdLabel,
                controller: firstPartyIdController,
                validatorMessage: localizations.firstPartyIdValidation,
              ),
              const SizedBox(height: 16),

              // First Party Address
              buildLabeledTextField(
                label: localizations.firstPartyAddressLabel,
                controller: firstPartyAddressController,
                validatorMessage: localizations.firstPartyAddressValidation,
              ),
              const SizedBox(height: 16),

              // First Party Phone
              buildLabeledTextField(
                label: localizations.firstPartyPhoneLabel,
                controller: firstPartyPhoneController,
                validatorMessage: localizations.firstPartyPhoneValidation,
              ),
              const SizedBox(height: 16),

              // Second Party Name
              buildLabeledTextField(
                label: localizations.secondPartyNameLabel,
                controller: secondPartyNameController,
                validatorMessage: localizations.secondPartyNameValidation,
              ),
              const SizedBox(height: 16),

              // Second Party ID
              buildLabeledTextField(
                label: localizations.secondPartyIdLabel,
                controller: secondPartyIdController,
                validatorMessage: localizations.secondPartyIdValidation,
              ),
              const SizedBox(height: 16),

              // Second Party Nationality
              buildLabeledTextField(
                label: localizations.secondPartyNationalityLabel,
                controller: secondPartyNationalityController,
                validatorMessage: localizations.secondPartyNationalityValidation,
              ),
              const SizedBox(height: 16),

              // Second Party Address
              buildLabeledTextField(
                label: localizations.secondPartyAddressLabel,
                controller: secondPartyAddressController,
                validatorMessage: localizations.secondPartyAddressValidation,
              ),
              const SizedBox(height: 16),

              // Second Party Phone
              buildLabeledTextField(
                label: localizations.secondPartyPhoneLabel,
                controller: secondPartyPhoneController,
                validatorMessage: localizations.secondPartyPhoneValidation,
              ),
              const SizedBox(height: 16),

              // Job Title
              buildLabeledTextField(
                label: localizations.jobTitleLabel,
                controller: jobTitleController,
                validatorMessage: localizations.jobTitleValidation,
              ),
              const SizedBox(height: 16),

              // Contract Start Date
              buildLabeledTextField(
                label: localizations.contractStartDateLabel,
                controller: contractStartDateController,
                validatorMessage: localizations.contractStartDateValidation,
              ),
              const SizedBox(height: 16),

              // Daily Wage
              buildLabeledTextField(
                label: localizations.dailyWageLabel,
                controller: dailyWageController,
                validatorMessage: localizations.dailyWageValidation,
              ),
              const SizedBox(height: 16),

              // Working Hours
              buildLabeledTextField(
                label: localizations.workingHoursLabel,
                controller: workingHoursController,
                validatorMessage: localizations.workingHoursValidation,
              ),
              const SizedBox(height: 16),

              // Break Duration
              buildLabeledTextField(
                label: localizations.breakDurationLabel,
                controller: breakDurationController,
                validatorMessage: localizations.breakDurationValidation,
              ),
              const SizedBox(height: 32),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log(localizations.successMessage);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(localizations.successMessage)),
                      );
                    } else {
                      log(localizations.errorMessage);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: Text(
                    localizations.saveButton,
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
