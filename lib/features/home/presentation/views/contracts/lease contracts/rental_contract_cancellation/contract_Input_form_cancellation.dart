import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormCancellation extends StatefulWidget {
  const ContractInputFormCancellation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaseCancellationFormState createState() => _LeaseCancellationFormState();
}

// done

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
        title: const Text('Lease Cancellation Form'),
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

              // Tenant Name
              buildLabeledTextField(
                label: 'Tenant Name',
                controller: tenantNameController,
                validatorMessage: 'Please enter the tenant\'s name',
              ),
              const SizedBox(height: 16),

              // Contract Start Date
              buildLabeledTextField(
                label: 'Contract Start Date',
                controller: contractStartDateController,
                validatorMessage: 'Please enter the contract start date',
              ),
              const SizedBox(height: 16),

              // Contract End Date
              buildLabeledTextField(
                label: 'Contract End Date',
                controller: contractEndDateController,
                validatorMessage: 'Please enter the contract end date',
              ),
              const SizedBox(height: 16),

              // Reason for Cancellation
              buildLabeledTextField(
                label: 'Reason for Cancellation',
                controller: cancellationReasonController,
                validatorMessage: 'Please enter a reason for cancellation',
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
                        const SnackBar(
                            content: Text('Form submitted successfully')),
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
                    "Submit",
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
