import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormProperty extends StatefulWidget {
  const ContractInputFormProperty({super.key});

  @override
  State<ContractInputFormProperty> createState() =>
      _ContractInputFormPropertyState();
}

class _ContractInputFormPropertyState extends State<ContractInputFormProperty> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();
  final TextEditingController sellerAddressController = TextEditingController();
  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController buyerIdController = TextEditingController();
  final TextEditingController buyerAddressController = TextEditingController();
  final TextEditingController propertyAddressController =
      TextEditingController();
  final TextEditingController propertySizeController = TextEditingController();
  final TextEditingController propertyPriceController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController saleDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(QTexts.appBarTitleProperty),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Section for seller information
              const Text(
                QTexts.sellerInfoProperty,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.sellerName,
                controller: sellerNameController,
                validatorMessage: QTexts.sellerNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.sellerId,
                controller: sellerIdController,
                validatorMessage: QTexts.sellerIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.sellerAddress,
                controller: sellerAddressController,
                validatorMessage: QTexts.sellerAddressValidation,
              ),
              const SizedBox(height: 32),

              // Buyer Information Section
              const Text(
                QTexts.buyerInfoProperty,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.buyerName,
                controller: buyerNameController,
                validatorMessage: QTexts.buyerNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.buyerId,
                controller: buyerIdController,
                validatorMessage: QTexts.buyerIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.buyerAddress,
                controller: buyerAddressController,
                validatorMessage: QTexts.buyerAddressValidation,
              ),
              const SizedBox(height: 32),

              // Property Information Section
              const Text(
                QTexts.propertyInfoProperty,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.propertyAddress,
                controller: propertyAddressController,
                validatorMessage: QTexts.propertyAddressValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.propertySize,
                controller: propertySizeController,
                validatorMessage: QTexts.propertySizeValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.propertyPrice,
                controller: propertyPriceController,
                validatorMessage: QTexts.propertyPriceValidation,
              ),
              const SizedBox(height: 32),

              // Transaction Information Section
              const Text(
                QTexts.transactionInfoProperty,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.paymentMethod,
                controller: paymentMethodController,
                validatorMessage: QTexts.paymentMethodValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.saleDate,
                controller: saleDateController,
                validatorMessage: QTexts.saleDateValidation,
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
                            content: Text(QTexts.dateEnteredSuccessfuly)),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: const Text(
                    QTexts.saveButton,
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
