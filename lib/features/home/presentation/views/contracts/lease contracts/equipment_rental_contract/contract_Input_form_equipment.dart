import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import localization package

import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormEquipment extends StatefulWidget {
  const ContractInputFormEquipment({super.key});

  @override
  State<ContractInputFormEquipment> createState() =>
      _EquipmentRentalContractFormState();
}

class _EquipmentRentalContractFormState
    extends State<ContractInputFormEquipment> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController landlordNameController =
      TextEditingController(); // Landlord Name
  final TextEditingController landlordAddressController =
      TextEditingController(); // Landlord Address
  final TextEditingController tenantNameController =
      TextEditingController(); // Tenant Name
  final TextEditingController tenantAddressController =
      TextEditingController(); // Tenant Address
  final TextEditingController equipmentNameController =
      TextEditingController(); // Equipment Name
  final TextEditingController equipmentBrandController =
      TextEditingController(); // Equipment Brand
  final TextEditingController manufactureDateController =
      TextEditingController(); // Manufacture Date
  final TextEditingController equipmentQuantityController =
      TextEditingController(); // Equipment Quantity
  final TextEditingController rentValueController =
      TextEditingController(); // Rent Value
  final TextEditingController startDateController =
      TextEditingController(); // Contract Start Date
  final TextEditingController endDateController =
      TextEditingController(); // Contract End Date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!
            .contractInputTitle), // Use localization here
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

              // Landlord Address
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.landlordAddress,
                controller: landlordAddressController,
                validatorMessage:
                    AppLocalizations.of(context)!.landlordAddressValidator,
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

              // Tenant Address
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.tenantAddress,
                controller: tenantAddressController,
                validatorMessage:
                    AppLocalizations.of(context)!.tenantAddressValidator,
              ),
              const SizedBox(height: 16),

              // Equipment Name
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.equipmentName,
                controller: equipmentNameController,
                validatorMessage:
                    AppLocalizations.of(context)!.equipmentNameValidator,
              ),
              const SizedBox(height: 16),

              // Equipment Brand
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.equipmentBrand,
                controller: equipmentBrandController,
                validatorMessage:
                    AppLocalizations.of(context)!.equipmentBrandValidator,
              ),
              const SizedBox(height: 16),

              // Manufacture Date
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.manufactureDate,
                controller: manufactureDateController,
                validatorMessage:
                    AppLocalizations.of(context)!.manufactureDateValidator,
              ),
              const SizedBox(height: 16),

              // Equipment Quantity
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.equipmentQuantity,
                controller: equipmentQuantityController,
                validatorMessage:
                    AppLocalizations.of(context)!.equipmentQuantityValidator,
              ),
              const SizedBox(height: 16),

              // Rent Value
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.rentValue,
                controller: rentValueController,
                validatorMessage:
                    AppLocalizations.of(context)!.rentValueValidator,
              ),
              const SizedBox(height: 16),

              // Contract Start Date
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.contractStartDate,
                controller: startDateController,
                validatorMessage:
                    AppLocalizations.of(context)!.contractStartDateValidator,
              ),
              const SizedBox(height: 16),

              // Contract End Date
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.contractEndDate,
                controller: endDateController,
                validatorMessage:
                    AppLocalizations.of(context)!.contractEndDateValidator,
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
                        const SnackBar(
                            content: Text('Data entered successfully')),
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
                    AppLocalizations.of(context)!
                        .saveButton, // Use localization here
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
          style: Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
        ),
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
