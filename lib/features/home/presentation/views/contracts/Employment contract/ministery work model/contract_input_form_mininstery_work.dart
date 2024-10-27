import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';

import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormMininsteryWork extends StatefulWidget {
  const ContractInputFormMininsteryWork({super.key});

  @override
  State<ContractInputFormMininsteryWork> createState() =>
      _MinistryLaborContractFormState();
}

class _MinistryLaborContractFormState
    extends State<ContractInputFormMininsteryWork> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController firstPartyController = TextEditingController();
  final TextEditingController legalRepController = TextEditingController();
  final TextEditingController commercialRegisterController =
      TextEditingController();
  final TextEditingController firstPartyAddressController =
      TextEditingController();
  final TextEditingController firstPartyPhoneController =
      TextEditingController();
  final TextEditingController secondPartyController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController secondPartyAddressController =
      TextEditingController();
  final TextEditingController secondPartyPhoneController =
      TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController contractDurationController =
      TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.title),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildLabeledTextField(
                label: localizations.first_party,
                controller: firstPartyController,
                validatorMessage: localizations.enter_first_party_name,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.legal_rep,
                controller: legalRepController,
                validatorMessage: localizations.enter_legal_rep,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.commercial_register,
                controller: commercialRegisterController,
                validatorMessage: localizations.enter_commercial_register,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.first_party_address,
                controller: firstPartyAddressController,
                validatorMessage: localizations.enter_first_party_address,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.first_party_phone,
                controller: firstPartyPhoneController,
                validatorMessage: localizations.enter_first_party_phone,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.second_party,
                controller: secondPartyController,
                validatorMessage: localizations.enter_second_party_name,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.nationality,
                controller: nationalityController,
                validatorMessage: localizations.enter_nationality,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.id,
                controller: idController,
                validatorMessage: localizations.enter_id,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.second_party_address,
                controller: secondPartyAddressController,
                validatorMessage: localizations.enter_second_party_address,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.second_party_phone,
                controller: secondPartyPhoneController,
                validatorMessage: localizations.enter_second_party_phone,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.job_title,
                controller: jobTitleController,
                validatorMessage: localizations.enter_job_title,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.contract_duration,
                controller: contractDurationController,
                validatorMessage: localizations.enter_contract_duration,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.salary,
                controller: salaryController,
                validatorMessage: localizations.enter_salary,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.start_date,
                controller: startDateController,
                validatorMessage: localizations.enter_start_date,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log(localizations.success_message);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(localizations.success_message),
                        ),
                      );
                      GoRouter.of(context).push(AppRouter.kSuccessView);
                    } else {
                      log(localizations.error_message);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: Text(
                    localizations.submit,
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
