import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContractInputFormWaiverBusinessPartnership extends StatefulWidget {
  const ContractInputFormWaiverBusinessPartnership({super.key});

  @override
  State<ContractInputFormWaiverBusinessPartnership> createState() =>
      _ContractInputFormWaiverBusinessPartnershipArabicState();
}

class _ContractInputFormWaiverBusinessPartnershipArabicState
    extends State<ContractInputFormWaiverBusinessPartnership> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();
  final TextEditingController sellerAddressController = TextEditingController();
  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController buyerIdController = TextEditingController();
  final TextEditingController buyerAddressController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();
  final TextEditingController businessDetailsController =
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
        title: Text(localizations.appBarTitleWaiverBusinessPartnership),
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                localizations.businessDetails,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: localizations.businessType,
                controller: businessTypeController,
                validatorMessage: localizations.businessTypeValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.businessDetailsLabel,
                controller: businessDetailsController,
                validatorMessage: localizations.businessDetailsValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: localizations.waiverReason,
                controller: waiverReasonController,
                validatorMessage: localizations.waiverReasonValidation,
              ),
              const SizedBox(height: 32),
              Text(
                localizations.transactionDetails,
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
                      log('النموذج صالح. حفظ البيانات.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(localizations.dataEnteredSuccessfully)),
                      );
                    } else {
                      log('النموذج غير صالح. إظهار الأخطاء.');
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
