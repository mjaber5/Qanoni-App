import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // تأكد من إضافة مكتبة الوكاليزيشن
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormCar extends StatefulWidget {
  const ContractInputFormCar({super.key});

  @override
  State<ContractInputFormCar> createState() => _ContractInputFormState();
}

class _ContractInputFormState extends State<ContractInputFormCar> {
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
  final TextEditingController carModelController =
      TextEditingController(); // Car Model
  final TextEditingController carTypeController =
      TextEditingController(); // Car Type
  final TextEditingController carColorController =
      TextEditingController(); // Car Color
  final TextEditingController engineCapacityController =
      TextEditingController(); // Engine Capacity
  final TextEditingController rentAmountController =
      TextEditingController(); // Rent Amount
  final TextEditingController startDateController =
      TextEditingController(); // Contract Start Date
  final TextEditingController contractDurationController =
      TextEditingController(); // Contract Duration

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.contractInputTitle),
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

              // Car Type
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.carType,
                controller: carTypeController,
                validatorMessage: AppLocalizations.of(context)!.carTypeValidator,
              ),
              const SizedBox(height: 16),

              // Car Model
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.carModel,
                controller: carModelController,
                validatorMessage: AppLocalizations.of(context)!.carModelValidator,
              ),
              const SizedBox(height: 16),

              // Car Color
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.carColor,
                controller: carColorController,
                validatorMessage: AppLocalizations.of(context)!.carColorValidator,
              ),
              const SizedBox(height: 16),

              // Engine Capacity
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.engineCapacity,
                controller: engineCapacityController,
                validatorMessage: AppLocalizations.of(context)!.engineCapacityValidator,
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
                    AppLocalizations.of(context)!.saveButton,
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
