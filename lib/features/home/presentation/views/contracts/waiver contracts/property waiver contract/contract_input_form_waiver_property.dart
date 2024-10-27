import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // استيراد الترجمة المحلية

import '../../../../../../../core/utils/constants/colors.dart';
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
        title: Text(AppLocalizations.of(context)!.appBarTitleWaiverProperty),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                AppLocalizations.of(context)!.sellerInfo,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.sellerName,
                controller: sellerNameController,
                validatorMessage: AppLocalizations.of(context)!.sellerNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.sellerId,
                controller: sellerIdController,
                validatorMessage: AppLocalizations.of(context)!.sellerIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.sellerAddress,
                controller: sellerAddressController,
                validatorMessage: AppLocalizations.of(context)!.sellerAddressValidation,
              ),
              const SizedBox(height: 32),
              Text(
                AppLocalizations.of(context)!.buyerInfo,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.buyerName,
                controller: buyerNameController,
                validatorMessage: AppLocalizations.of(context)!.buyerNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.buyerId,
                controller: buyerIdController,
                validatorMessage: AppLocalizations.of(context)!.buyerIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.buyerAddress,
                controller: buyerAddressController,
                validatorMessage: AppLocalizations.of(context)!.buyerAddressValidation,
              ),
              const SizedBox(height: 32),
              Text(
                AppLocalizations.of(context)!.propertyInfo,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.propertyType,
                controller: propertyTypeController,
                validatorMessage: AppLocalizations.of(context)!.propertyTypeValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.propertyDetails,
                controller: propertyDetailsController,
                validatorMessage: AppLocalizations.of(context)!.propertyDetailsValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.waiverReason,
                controller: waiverReasonController,
                validatorMessage: AppLocalizations.of(context)!.waiverReasonValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.ownershipStatus,
                controller: ownershipController,
                validatorMessage: AppLocalizations.of(context)!.ownershipStatusValidation,
              ),
              const SizedBox(height: 32),
              Text(
                AppLocalizations.of(context)!.transactionInfo,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.waiverPrice,
                controller: waiverPriceController,
                validatorMessage: AppLocalizations.of(context)!.waiverPriceValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.paymentMethod,
                controller: paymentMethodController,
                validatorMessage: AppLocalizations.of(context)!.paymentMethodValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.waiverDate,
                controller: waiverDateController,
                validatorMessage: AppLocalizations.of(context)!.waiverDateValidation,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log('Form is valid. Proceed with saving the contract.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(AppLocalizations.of(context)!.dataEnteredSuccessfully)),
                      );
                    } else {
                      log('Form is not valid. Show errors.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.saveButton,
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
