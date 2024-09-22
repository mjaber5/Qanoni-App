import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
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
        title: const Text(QTexts.carSaleContractInfoAppBar),
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
                label: QTexts.dateLabel,
                controller: dateController,
                validatorMessage: QTexts.validatoreMessageEnterDate,
              ),
              const SizedBox(height: 16),

              // 2. Seller and Buyer Information
              const Text(
                QTexts.paritesInformation,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.sellerName,
                controller: sellerNameController,
                validatorMessage: QTexts.sellerNameValidatoreMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.sellerAddress,
                controller: sellerAddressController,
                validatorMessage: QTexts.sellerAddressValidatoreMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.buyerName,
                controller: buyerNameController,
                validatorMessage: QTexts.buyerNameValidatorMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.buyerAddress,
                controller: buyerAddressController,
                validatorMessage: QTexts.buyerAddressValidatorMessage,
              ),
              const SizedBox(height: 32),

              // 3. Property Details
              const Text(
                QTexts.propertyDetails,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.propertyType,
                controller: propertyTypeController,
                validatorMessage: QTexts.propertyTypeValidatorMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.propertyNumber,
                controller: propertyNumberController,
                validatorMessage: QTexts.propertyNumberValidatorMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.parcelNumber,
                controller: landParcelNumberController,
                validatorMessage: QTexts.parcelNumberValidatorMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.landArea,
                controller: landAreaController,
                validatorMessage: QTexts.landAreaValidatorMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.apartmentNumber,
                controller: apartmentNumberController,
                validatorMessage: QTexts.apartmentNumberValidatorMessage,
              ),
              const SizedBox(height: 32),

              // 4. Property Price
              const Text(
                QTexts.propertyPrice,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.amountLabel,
                controller: priceController,
                validatorMessage: QTexts.amountLabelValidatorMessage,
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
                          content: Text(QTexts.dateEnteredSuccessfuly),
                        ),
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
