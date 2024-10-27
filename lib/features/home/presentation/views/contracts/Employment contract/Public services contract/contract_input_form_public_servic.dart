import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // استيراد AppLocalizations

import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormPublicServic extends StatefulWidget {
  const ContractInputFormPublicServic({super.key});

  @override
  State<ContractInputFormPublicServic> createState() =>
      _ServiceContractInputFormState();
}

class _ServiceContractInputFormState
    extends State<ContractInputFormPublicServic> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController firstPartyController = TextEditingController();
  final TextEditingController secondPartyController = TextEditingController();
  final TextEditingController serviceDescriptionController =
      TextEditingController();
  final TextEditingController contractDurationController =
      TextEditingController();
  final TextEditingController serviceFeeController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.input_contract_data),
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
                label: localizations.first_party_name,
                controller: firstPartyController,
                validatorMessage: localizations.enter_first_party_name,
              ),
              const SizedBox(height: 16),

              // Second Party Name
              buildLabeledTextField(
                label: localizations.second_party_name,
                controller: secondPartyController,
                validatorMessage: localizations.enter_second_party_name,
              ),
              const SizedBox(height: 16),

              // Service Description
              buildLabeledTextField(
                label: localizations.service_description,
                controller: serviceDescriptionController,
                validatorMessage: localizations.enter_service_description,
              ),
              const SizedBox(height: 16),

              // Contract Duration
              buildLabeledTextField(
                label: localizations.contract_duration,
                controller: contractDurationController,
                validatorMessage: localizations.enter_contract_duration,
              ),
              const SizedBox(height: 16),

              // Service Fee
              buildLabeledTextField(
                label: localizations.service_fee,
                controller: serviceFeeController,
                validatorMessage: localizations.enter_service_fee,
              ),
              const SizedBox(height: 16),

              // Start Date
              buildLabeledTextField(
                label: localizations.start_date,
                controller: startDateController,
                validatorMessage: localizations.enter_start_date,
              ),
              const SizedBox(height: 32),

              // Submit Button
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
                    } else {
                      log(localizations.error_message);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: Text(
                    localizations.save,
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
