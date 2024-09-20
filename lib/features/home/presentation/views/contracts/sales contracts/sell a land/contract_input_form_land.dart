import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormLand extends StatefulWidget {
  const ContractInputFormLand({super.key});

  @override
  State<ContractInputFormLand> createState() =>
      _ContractInputFormPropertyState();
}

class _ContractInputFormPropertyState extends State<ContractInputFormLand> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController dateController = TextEditingController();
  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController sellerAddressController = TextEditingController();
  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController buyerAddressController = TextEditingController();
  final TextEditingController propertyTypeController = TextEditingController();
  final TextEditingController propertyNumberController =
      TextEditingController();
  final TextEditingController landParcelNumberController =
      TextEditingController();
  final TextEditingController landAreaController = TextEditingController();
  final TextEditingController apartmentNumberController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Property Sale Contract Information'),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // 1. Date
              buildLabeledTextField(
                label: 'Date',
                controller: dateController,
                validatorMessage: 'Please enter the date',
              ),
              const SizedBox(height: 16),

              // 2. Seller and Buyer Information
              const Text(
                'Parties Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'Seller Name',
                controller: sellerNameController,
                validatorMessage: 'Please enter the seller\'s name',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Seller Address',
                controller: sellerAddressController,
                validatorMessage: 'Please enter the seller\'s address',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Buyer Name',
                controller: buyerNameController,
                validatorMessage: 'Please enter the buyer\'s name',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Buyer Address',
                controller: buyerAddressController,
                validatorMessage: 'Please enter the buyer\'s address',
              ),
              const SizedBox(height: 32),

              // 3. Property Details
              const Text(
                'Property Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'Property Type',
                controller: propertyTypeController,
                validatorMessage: 'Please enter the property type',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Property Number',
                controller: propertyNumberController,
                validatorMessage: 'Please enter the property number',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Parcel Number',
                controller: landParcelNumberController,
                validatorMessage: 'Please enter the parcel number',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Land Area',
                controller: landAreaController,
                validatorMessage: 'Please enter the land area',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Apartment Number',
                controller: apartmentNumberController,
                validatorMessage: 'Please enter the apartment number',
              ),
              const SizedBox(height: 32),

              // 4. Property Price
              const Text(
                'Property Price',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'Amount',
                controller: priceController,
                validatorMessage: 'Please enter the price of the property',
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
