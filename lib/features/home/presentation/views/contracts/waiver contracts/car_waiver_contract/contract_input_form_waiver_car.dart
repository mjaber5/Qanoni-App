import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // تأكد من استيراد الحزمة الصحيحة
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';

import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormWaiverCar extends StatefulWidget {
  const ContractInputFormWaiverCar({super.key});

  @override
  State<ContractInputFormWaiverCar> createState() =>
      _ContractInputFormWaiverCarState();
}

class _ContractInputFormWaiverCarState
    extends State<ContractInputFormWaiverCar> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();
  final TextEditingController sellerAddressController = TextEditingController();
  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController buyerIdController = TextEditingController();
  final TextEditingController buyerAddressController = TextEditingController();
  final TextEditingController assetTypeController = TextEditingController();
  final TextEditingController assetDetailsController = TextEditingController();
  final TextEditingController waiverReasonController = TextEditingController();
  final TextEditingController ownershipController = TextEditingController();
  final TextEditingController waiverPriceController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController waiverDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appBarTitleWaiverCar),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                localizations.sellerInfo,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: localizations.sellerName,
                controller: sellerNameController,
                validatorMessage: localizations.sellerNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.sellerId,
                controller: sellerIdController,
                validatorMessage: localizations.sellerIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.sellerAddress,
                controller: sellerAddressController,
                validatorMessage: localizations.sellerAddressValidation,
              ),
              const SizedBox(height: 32),
              Text(
                localizations.buyerInfo,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: localizations.buyerName,
                controller: buyerNameController,
                validatorMessage: localizations.buyerNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.buyerId,
                controller: buyerIdController,
                validatorMessage: localizations.buyerIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.buyerAddress,
                controller: buyerAddressController,
                validatorMessage: localizations.buyerAddressValidation,
              ),
              const SizedBox(height: 32),
              Text(
                localizations.waiverInfo,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: localizations.assetType,
                controller: assetTypeController,
                validatorMessage: localizations.assetTypeValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.assetDetails,
                controller: assetDetailsController,
                validatorMessage: localizations.assetDetailsValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.waiverReason,
                controller: waiverReasonController,
                validatorMessage: localizations.waiverReasonValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.ownershipStatus,
                controller: ownershipController,
                validatorMessage: localizations.ownershipStatusValidation,
              ),
              const SizedBox(height: 32),
              Text(
                localizations.transactionInfo,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      log('Form is valid. Saving data.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text(localizations.dataEnteredSuccessfully)),
                      );
                      GoRouter.of(context).push(AppRouter.kSuccessView);
                    } else {
                      log('Form is invalid. Showing errors.');
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
