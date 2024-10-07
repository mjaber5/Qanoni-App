import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart'; // تأكد من أن لديك ملف النصوص الصحيح

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(QTexts.appBarTitleWaiverCar),
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
                QTexts.waiverInfo,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: QTexts.assetType,
                controller: assetTypeController,
                validatorMessage: QTexts.assetTypeValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: QTexts.assetDetails,
                controller: assetDetailsController,
                validatorMessage: QTexts.assetDetailsValidation,
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
                      log('النموذج صالح. حفظ البيانات.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(QTexts.dataEnteredSuccessfully)),
                      );
                    } else {
                      log('النموذج غير صالح. إظهار الأخطاء.');
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
