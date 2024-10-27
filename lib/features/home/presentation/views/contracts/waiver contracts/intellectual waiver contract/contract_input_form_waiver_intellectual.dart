import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../core/utils/constants/colors.dart';
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
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appBarTitleWaiverIntellectual),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                localizations.rightsHolderInfo,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: localizations.rightsHolderName,
                controller: ownerNameController,
                validatorMessage: localizations.rightsHolderNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.rightsHolderId,
                controller: ownerIdController,
                validatorMessage: localizations.rightsHolderIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.rightsHolderAddress,
                controller: ownerAddressController,
                validatorMessage: localizations.rightsHolderAddressValidation,
              ),
              const SizedBox(height: 32),
              Text(
                localizations.transfereeInfo,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: localizations.transfereeName,
                controller: receiverNameController,
                validatorMessage: localizations.transfereeNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.transfereeId,
                controller: receiverIdController,
                validatorMessage: localizations.transfereeIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.transfereeAddress,
                controller: receiverAddressController,
                validatorMessage: localizations.transfereeAddressValidation,
              ),
              const SizedBox(height: 32),
              Text(
                localizations.rightsInfo,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: localizations.rightsType,
                controller: intellectualPropertyTypeController,
                validatorMessage: localizations.rightsTypeValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.rightsDetails,
                controller: intellectualPropertyDetailsController,
                validatorMessage: localizations.rightsDetailsValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.waiverReason,
                controller: waiverReasonController,
                validatorMessage: localizations.waiverReasonValidation,
              ),
              const SizedBox(height: 32),
              Text(
                localizations.transactionInfo,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: localizations.waiverPrice,
                controller: waiverPriceController,
                validatorMessage: localizations.waiverPriceValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.paymentMethod,
                controller: paymentMethodController,
                validatorMessage: localizations.paymentMethodValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.waiverDate,
                controller: waiverDateController,
                validatorMessage: localizations.waiverDateValidation,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log('Valid form. Saving data.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(localizations.dataEnteredSuccessfully)),
                      );
                    } else {
                      log('Invalid form. Showing errors.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: Text(
                    localizations.saveButton,
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
