import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormEquipmentt extends StatefulWidget {
  const ContractInputFormEquipmentt({super.key});

  @override
  State<ContractInputFormEquipmentt> createState() =>
      _ContractInputFormEquipmentState();
}

class _ContractInputFormEquipmentState
    extends State<ContractInputFormEquipmentt> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController vendorNameController = TextEditingController();
  final TextEditingController vendorAddressController = TextEditingController();
  final TextEditingController purchaserNameController = TextEditingController();
  final TextEditingController purchaserAddressController = TextEditingController();
  final TextEditingController equipmentTypeController = TextEditingController();
  final TextEditingController equipmentModelController = TextEditingController();
  final TextEditingController equipmentSerialNumberController = TextEditingController();
  final TextEditingController equipmentConditionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController saleDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Equipment Sale Contract Information'),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // 1. Vendor and Purchaser Information
              const Text(
                'Parties Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'Vendor Name',
                controller: vendorNameController,
                validatorMessage: 'Please enter the vendor\'s name',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Vendor Address',
                controller: vendorAddressController,
                validatorMessage: 'Please enter the vendor\'s address',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Purchaser Name',
                controller: purchaserNameController,
                validatorMessage: 'Please enter the purchaser\'s name',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Purchaser Address',
                controller: purchaserAddressController,
                validatorMessage: 'Please enter the purchaser\'s address',
              ),
              const SizedBox(height: 32),

              // 2. Equipment Details
              const Text(
                'Equipment Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'Equipment Type',
                controller: equipmentTypeController,
                validatorMessage: 'Please enter the equipment type',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Equipment Model',
                controller: equipmentModelController,
                validatorMessage: 'Please enter the equipment model',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Serial Number',
                controller: equipmentSerialNumberController,
                validatorMessage: 'Please enter the equipment serial number',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Condition',
                controller: equipmentConditionController,
                validatorMessage: 'Please enter the equipment condition',
              ),
              const SizedBox(height: 32),

              // 3. Sale Details
              const Text(
                'Sale Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'Price',
                controller: priceController,
                validatorMessage: 'Please enter the price',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Sale Date',
                controller: saleDateController,
                validatorMessage: 'Please enter the sale date',
              ),
              const SizedBox(height: 32),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Data entered successfully')),
                      );
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
