import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // تأكد من استيراد ملف localization
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormCarSales extends StatefulWidget {
  const ContractInputFormCarSales({super.key});

  @override
  State<ContractInputFormCarSales> createState() =>
      _ContractInputFormCarSalesState();
}

class _ContractInputFormCarSalesState extends State<ContractInputFormCarSales> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();
  final TextEditingController sellerAddressController = TextEditingController();
  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController buyerIdController = TextEditingController();
  final TextEditingController buyerAddressController = TextEditingController();
  final TextEditingController carBrandController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carYearController = TextEditingController();
  final TextEditingController vinController = TextEditingController(); // Vehicle Identification Number (VIN)
  final TextEditingController mechanicalConditionController = TextEditingController();
  final TextEditingController ownershipController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController saleDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appBarTitleCar),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Seller Information Section
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

              // Buyer Information Section
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

              // Car Information Section
              Text(
                AppLocalizations.of(context)!.propertyInfoCar,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.carBrand,
                controller: carBrandController,
                validatorMessage: AppLocalizations.of(context)!.carBrandValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.carModel,
                controller: carModelController,
                validatorMessage: AppLocalizations.of(context)!.carModelValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.carYear,
                controller: carYearController,
                validatorMessage: AppLocalizations.of(context)!.carYearValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.vin,
                controller: vinController,
                validatorMessage: AppLocalizations.of(context)!.vinValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.mechanicalCondition,
                controller: mechanicalConditionController,
                validatorMessage: AppLocalizations.of(context)!.mechanicalConditionValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.ownershipStatus,
                controller: ownershipController,
                validatorMessage: AppLocalizations.of(context)!.ownershipStatusValidation,
              ),
              const SizedBox(height: 32),

              // Transaction Information Section
              Text(
                AppLocalizations.of(context)!.transactionInfo,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.sellingPrice,
                controller: sellingPriceController,
                validatorMessage: AppLocalizations.of(context)!.sellingPriceValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.paymentMethod,
                controller: paymentMethodController,
                validatorMessage: AppLocalizations.of(context)!.paymentMethodValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.saleDate,
                controller: saleDateController,
                validatorMessage: AppLocalizations.of(context)!.saleDateValidation,
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    log('Form submitted successfully');
                  }
                },
                child: Text(AppLocalizations.of(context)!.saveButton),
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
    return  Column(
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
