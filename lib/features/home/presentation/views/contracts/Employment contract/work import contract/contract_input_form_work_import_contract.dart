import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormWorkImportContract extends StatefulWidget {
  const ContractInputFormWorkImportContract({super.key});

  @override
  State<ContractInputFormWorkImportContract> createState() =>
      _RecruitmentContractInputFormState();
}

class _RecruitmentContractInputFormState
    extends State<ContractInputFormWorkImportContract> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController firstPartyController =
      TextEditingController(); // الطرف الأول
  final TextEditingController firstPartyIdController =
      TextEditingController(); // رقم هوية الطرف الأول
  final TextEditingController nationalityController =
      TextEditingController(); // جنسية الطرف الأول
  final TextEditingController secondPartyController =
      TextEditingController(); // الطرف الثاني
  final TextEditingController secondPartyPassportController =
      TextEditingController(); // رقم جواز سفر الطرف الثاني
  final TextEditingController secondPartyNationalityController =
      TextEditingController(); // جنسية الطرف الثاني
  final TextEditingController jobTitleController =
      TextEditingController(); // الوظيفة
  final TextEditingController contractDurationController =
      TextEditingController(); // مدة العقد
  final TextEditingController salaryController =
      TextEditingController(); // الأجر
  final TextEditingController startDateController =
      TextEditingController(); // تاريخ بدء العقد

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.contractInputFormTitle),
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
                label: AppLocalizations.of(context)!.firstPartyLabel,
                controller: firstPartyController,
                validatorMessage: AppLocalizations.of(context)!.firstPartyValidator,
              ),
              const SizedBox(height: 16),

              // First Party ID
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.firstPartyIdLabel,
                controller: firstPartyIdController,
                validatorMessage: AppLocalizations.of(context)!.firstPartyIdValidator,
              ),
              const SizedBox(height: 16),

              // First Party Nationality
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.firstPartyNationalityLabel,
                controller: nationalityController,
                validatorMessage: AppLocalizations.of(context)!.firstPartyNationalityValidator,
              ),
              const SizedBox(height: 16),

              // Second Party Name
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.secondPartyLabel,
                controller: secondPartyController,
                validatorMessage: AppLocalizations.of(context)!.secondPartyValidator,
              ),
              const SizedBox(height: 16),

              // Second Party Passport
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.secondPartyPassportLabel,
                controller: secondPartyPassportController,
                validatorMessage: AppLocalizations.of(context)!.secondPartyPassportValidator,
              ),
              const SizedBox(height: 16),

              // Second Party Nationality
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.secondPartyNationalityLabel,
                controller: secondPartyNationalityController,
                validatorMessage: AppLocalizations.of(context)!.secondPartyNationalityValidator,
              ),
              const SizedBox(height: 16),

              // Job Title
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.jobTitleLabel,
                controller: jobTitleController,
                validatorMessage: AppLocalizations.of(context)!.jobTitleValidator,
              ),
              const SizedBox(height: 16),

              // Contract Duration
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.contractDurationLabel,
                controller: contractDurationController,
                validatorMessage: AppLocalizations.of(context)!.contractDurationValidator,
              ),
              const SizedBox(height: 16),

              // Salary
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.salaryLabel,
                controller: salaryController,
                validatorMessage: AppLocalizations.of(context)!.salaryValidator,
              ),
              const SizedBox(height: 16),

              // Start Date
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.startDateLabel,
                controller: startDateController,
                validatorMessage: AppLocalizations.of(context)!.startDateValidator,
              ),
              const SizedBox(height: 32),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log(AppLocalizations.of(context)!.dataEnteredSuccess);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(AppLocalizations.of(context)!.dataEnteredSuccess)),
                      );
                    } else {
                      log(AppLocalizations.of(context)!.dataInvalid);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: Text(AppLocalizations.of(context)!.submitButton, style: Styles.textStyle18),
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
