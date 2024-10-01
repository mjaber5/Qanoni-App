import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormHouse extends StatefulWidget {
  const ContractInputFormHouse({super.key});

  @override
  State<ContractInputFormHouse> createState() => _ContractInputFormState();
}

class _ContractInputFormState extends State<ContractInputFormHouse> {
  final _formKey = GlobalKey<FormState>();

  // done

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
        title: const Text('Enter Lease Contract Information'),
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

              // Landlord ID
              buildLabeledTextField(
                label: 'Landlord ID',
                controller: landlordIdController,
                validatorMessage: 'Please enter the landlord\'s ID number',
              ),
              const SizedBox(height: 16),

              // Tenant Name
              buildLabeledTextField(
                label: 'Tenant Name',
                controller: tenantNameController,
                validatorMessage: 'Please enter the tenant\'s name',
              ),
              const SizedBox(height: 16),

              // Tenant ID
              buildLabeledTextField(
                label: 'Tenant ID',
                controller: tenantIdController,
                validatorMessage: 'Please enter the tenant\'s ID number',
              ),
              const SizedBox(height: 16),

              // Property Address
              buildLabeledTextField(
                label: 'Property Address',
                controller: propertyAddressController,
                validatorMessage: 'Please enter the property address',
              ),
              const SizedBox(height: 16),

              // City
              buildLabeledTextField(
                label: 'City',
                controller: cityController,
                validatorMessage: 'Please enter the city',
              ),
              const SizedBox(height: 16),

              // Contract Number
              buildLabeledTextField(
                label: 'Contract Number',
                controller: contractNumberController,
                validatorMessage: 'Please enter the contract number',
              ),
              const SizedBox(height: 16),

              // Rent Amount
              buildLabeledTextField(
                label: 'Rent Amount',
                controller: rentAmountController,
                validatorMessage: 'Please enter the rent amount',
              ),
              const SizedBox(height: 16),

              // Contract Start Date
              buildLabeledTextField(
                label: 'Contract Start Date',
                controller: startDateController,
                validatorMessage: 'Please enter the contract start date',
              ),
              const SizedBox(height: 16),

              // Contract Duration
              buildLabeledTextField(
                label: 'Contract Duration',
                controller: contractDurationController,
                validatorMessage: 'Please enter the contract duration',
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
