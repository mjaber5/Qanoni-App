import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/constants/text_strings.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormWaiverIntellectual extends StatefulWidget {
  const ContractInputFormWaiverIntellectual({super.key});

  @override
  State<ContractInputFormWaiverIntellectual> createState() =>
      _ContractInputFormWaiverIntellectualState();
}

class _ContractInputFormWaiverIntellectualState
    extends State<ContractInputFormWaiverIntellectual> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController ownerIdController = TextEditingController();
  final TextEditingController ownerAddressController = TextEditingController();
  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController receiverIdController = TextEditingController();
  final TextEditingController receiverAddressController =
      TextEditingController();
  final TextEditingController intellectualPropertyTypeController =
      TextEditingController();
  final TextEditingController intellectualPropertyDetailsController =
      TextEditingController();
  final TextEditingController waiverReasonController = TextEditingController();
  final TextEditingController waiverPriceController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController waiverDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(QTexts.appBarTitleWaiverIntellectual),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                QTexts.rightsHolderInfo,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.rightsHolderName,
                controller: ownerNameController,
                validatorMessage: QTexts.rightsHolderNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.rightsHolderId,
                controller: ownerIdController,
                validatorMessage: QTexts.rightsHolderIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.rightsHolderAddress,
                controller: ownerAddressController,
                validatorMessage: QTexts.rightsHolderAddressValidation,
              ),
              const SizedBox(height: 32),
              const Text(
                QTexts.transfereeInfo,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.transfereeName,
                controller: receiverNameController,
                validatorMessage: QTexts.transfereeNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.transfereeId,
                controller: receiverIdController,
                validatorMessage: QTexts.transfereeIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.transfereeAddress,
                controller: receiverAddressController,
                validatorMessage: QTexts.transfereeAddressValidation,
              ),
              const SizedBox(height: 32),
              const Text(
                QTexts.rightsInfo,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.rightsType,
                controller: intellectualPropertyTypeController,
                validatorMessage: QTexts.rightsTypeValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.rightsDetails,
                controller: intellectualPropertyDetailsController,
                validatorMessage: QTexts.rightsDetailsValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.waiverReason,
                controller: waiverReasonController,
                validatorMessage: QTexts.waiverReasonValidation,
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
                      log('Valid form. Saving data.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(QTexts.dataEnteredSuccessfully)),
                      );
                    } else {
                      log('Invalid form. Showing errors.');
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
