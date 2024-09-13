import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormEquipment extends StatefulWidget {
  const ContractInputFormEquipment({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EquipmentRentalContractFormState createState() => _EquipmentRentalContractFormState();
}

class _EquipmentRentalContractFormState extends State<ContractInputFormEquipment> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController landlordNameController = TextEditingController(); // Landlord Name
  final TextEditingController landlordAddressController = TextEditingController(); // Landlord Address
  final TextEditingController tenantNameController = TextEditingController(); // Tenant Name
  final TextEditingController tenantAddressController = TextEditingController(); // Tenant Address
  final TextEditingController equipmentNameController = TextEditingController(); // Equipment Name
  final TextEditingController equipmentBrandController = TextEditingController(); // Equipment Brand
  final TextEditingController manufactureDateController = TextEditingController(); // Manufacture Date
  final TextEditingController equipmentQuantityController = TextEditingController(); // Equipment Quantity
  final TextEditingController rentValueController = TextEditingController(); // Rent Value
  final TextEditingController startDateController = TextEditingController(); // Contract Start Date
  final TextEditingController endDateController = TextEditingController(); // Contract End Date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Equipment Rental Contract Information'),
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
                label: 'Landlord Name',
                controller: landlordNameController,
                validatorMessage: 'Please enter the landlord\'s name',
              ),
              const SizedBox(height: 16),

              // Landlord Address
              buildLabeledTextField(
                label: 'Landlord Address',
                controller: landlordAddressController,
                validatorMessage: 'Please enter the landlord\'s address',
              ),
              const SizedBox(height: 16),

              // Tenant Name
              buildLabeledTextField(
                label: 'Tenant Name',
                controller: tenantNameController,
                validatorMessage: 'Please enter the tenant\'s name',
              ),
              const SizedBox(height: 16),

              // Tenant Address
              buildLabeledTextField(
                label: 'Tenant Address',
                controller: tenantAddressController,
                validatorMessage: 'Please enter the tenant\'s address',
              ),
              const SizedBox(height: 16),

              // Equipment Name
              buildLabeledTextField(
                label: 'Equipment Name',
                controller: equipmentNameController,
                validatorMessage: 'Please enter the equipment name',
              ),
              const SizedBox(height: 16),

              // Equipment Brand
              buildLabeledTextField(
                label: 'Equipment Brand',
                controller: equipmentBrandController,
                validatorMessage: 'Please enter the equipment brand',
              ),
              const SizedBox(height: 16),

              // Manufacture Date
              buildLabeledTextField(
                label: 'Manufacture Date',
                controller: manufactureDateController,
                validatorMessage: 'Please enter the manufacture date',
              ),
              const SizedBox(height: 16),

              // Equipment Quantity
              buildLabeledTextField(
                label: 'Equipment Quantity',
                controller: equipmentQuantityController,
                validatorMessage: 'Please enter the equipment quantity',
              ),
              const SizedBox(height: 16),

              // Rent Value
              buildLabeledTextField(
                label: 'Rent Value',
                controller: rentValueController,
                validatorMessage: 'Please enter the rent value',
              ),
              const SizedBox(height: 16),

              // Contract Start Date
              buildLabeledTextField(
                label: 'Contract Start Date',
                controller: startDateController,
                validatorMessage: 'Please enter the contract start date',
              ),
              const SizedBox(height: 16),

              // Contract End Date
              buildLabeledTextField(
                label: 'Contract End Date',
                controller: endDateController,
                validatorMessage: 'Please enter the contract end date',
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
                  child: const Text(
                    "Save",
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
