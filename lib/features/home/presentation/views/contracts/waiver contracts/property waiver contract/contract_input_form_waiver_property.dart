import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/constants/text_strings.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormWaiverProperty extends StatefulWidget {
  const ContractInputFormWaiverProperty({super.key});

  @override
  State<ContractInputFormWaiverProperty> createState() =>
      _ContractInputFormWaiverPropertyState();
}

class _ContractInputFormWaiverPropertyState
    extends State<ContractInputFormWaiverProperty> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();
  final TextEditingController sellerAddressController = TextEditingController();
  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController buyerIdController = TextEditingController();
  final TextEditingController buyerAddressController = TextEditingController();
  final TextEditingController propertyTypeController = TextEditingController();
  final TextEditingController propertyDetailsController =
      TextEditingController();
  final TextEditingController waiverReasonController = TextEditingController();
  final TextEditingController ownershipController = TextEditingController();
  final TextEditingController waiverPriceController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController waiverDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(QTexts.appBarTitleWaiverProperty),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                QTexts.sellerInfo,
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

              const Text(
                QTexts.buyerInfo,
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

              const Text(
                QTexts.propertyInfo,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.propertyType,
                controller: propertyTypeController,
                validatorMessage: QTexts.propertyTypeValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.propertyDetails,
                controller: propertyDetailsController,
                validatorMessage: QTexts.propertyDetailsValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.waiverReason,
                controller: waiverReasonController,
                validatorMessage: QTexts.waiverReasonValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.ownershipStatus,
                controller: ownershipController,
                validatorMessage: QTexts.ownershipStatusValidation,
              ),
              const SizedBox(height: 32),

              const Text(
                QTexts.transactionInfo,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.waiverPrice,
                controller: waiverPriceController,
                validatorMessage: QTexts.waiverPriceValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.paymentMethod,
                controller: paymentMethodController,
                validatorMessage: QTexts.paymentMethodValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.waiverDate,
                controller: waiverDateController,
                validatorMessage: QTexts.waiverDateValidation,
              ),
              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log('Form is valid. Proceed with saving the contract.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(QTexts.dataEnteredSuccessfully)),
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
