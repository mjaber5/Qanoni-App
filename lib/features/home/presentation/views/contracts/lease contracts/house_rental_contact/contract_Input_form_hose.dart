import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import localization package
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormHouse extends StatefulWidget {
  const ContractInputFormHouse({super.key});

  @override
  State<ContractInputFormHouse> createState() => _ContractInputFormHouseState();
}

class _ContractInputFormHouseState extends State<ContractInputFormHouse> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController landlordNameController =
      TextEditingController(); // Landlord Name
  final TextEditingController landlordIdController =
      TextEditingController(); // Landlord ID
  final TextEditingController tenantNameController =
      TextEditingController(); // Tenant Name
  final TextEditingController tenantIdController =
      TextEditingController(); // Tenant ID
  final TextEditingController propertyAddressController =
      TextEditingController(); // Property Address
  final TextEditingController rentAmountController =
      TextEditingController(); // Rent Amount
  final TextEditingController startDateController =
      TextEditingController(); // Contract Start Date
  final TextEditingController contractDurationController =
      TextEditingController(); // Contract Duration
  final TextEditingController contractNumberController =
      TextEditingController(); // Contract Number
  final TextEditingController cityController = TextEditingController(); // City

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.contractInputTitle), // Use localization here
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
                validatorMessage: AppLocalizations.of(context)!.landlordNameValidator,
              ),
              const SizedBox(height: 16),

              // Landlord ID
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.landlordId,
                controller: landlordIdController,
                validatorMessage: AppLocalizations.of(context)!.landlordIdValidator,
              ),
              const SizedBox(height: 16),

              // Tenant Name
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.tenantName,
                controller: tenantNameController,
                validatorMessage: AppLocalizations.of(context)!.tenantNameValidator,
              ),
              const SizedBox(height: 16),

              // Tenant ID
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.tenantId,
                controller: tenantIdController,
                validatorMessage: AppLocalizations.of(context)!.tenantIdValidator,
              ),
              const SizedBox(height: 16),

              // Property Address
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.propertyAddress,
                controller: propertyAddressController,
                validatorMessage: AppLocalizations.of(context)!.propertyAddressValidator,
              ),
              const SizedBox(height: 16),

              // City
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.city,
                controller: cityController,
                validatorMessage: AppLocalizations.of(context)!.cityValidator,
              ),
              const SizedBox(height: 16),

              // Contract Number
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.contractNumber,
                controller: contractNumberController,
                validatorMessage: AppLocalizations.of(context)!.contractNumberValidator,
              ),
              const SizedBox(height: 16),

              // Rent Amount
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.rentAmount,
                controller: rentAmountController,
                validatorMessage: AppLocalizations.of(context)!.rentAmountValidator,
              ),
              const SizedBox(height: 16),

              // Contract Start Date
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.contractStartDate,
                controller: startDateController,
                validatorMessage: AppLocalizations.of(context)!.contractStartDateValidator,
              ),
              const SizedBox(height: 16),

              // Contract Duration
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.contractDuration,
                controller: contractDurationController,
                validatorMessage: AppLocalizations.of(context)!.contractDurationValidator,
              ),
              const SizedBox(height: 32),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log('Form is valid. Proceed with saving the contract.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data entered successfully')),
                      );
                    } else {
                      log('Form is not valid. Show errors.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.saveButton, // Use localization here
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
