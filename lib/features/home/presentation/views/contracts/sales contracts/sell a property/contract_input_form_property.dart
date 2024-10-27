import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // تأكد من استيراد حزمة التعريب
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';

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
        title: Text(AppLocalizations.of(context)!.appBarTitleProperty),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Section for seller information
              Text(
                AppLocalizations.of(context)!.sellerInfoProperty,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.sellerName,
                controller: sellerNameController,
                validatorMessage:
                    AppLocalizations.of(context)!.sellerNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.sellerId,
                controller: sellerIdController,
                validatorMessage:
                    AppLocalizations.of(context)!.sellerIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.sellerAddress,
                controller: sellerAddressController,
                validatorMessage:
                    AppLocalizations.of(context)!.sellerAddressValidation,
              ),
              const SizedBox(height: 32),

              // Buyer Information Section
              Text(
                AppLocalizations.of(context)!.buyerInfoProperty,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.buyerName,
                controller: buyerNameController,
                validatorMessage:
                    AppLocalizations.of(context)!.buyerNameValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.buyerId,
                controller: buyerIdController,
                validatorMessage:
                    AppLocalizations.of(context)!.buyerIdValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.buyerAddress,
                controller: buyerAddressController,
                validatorMessage:
                    AppLocalizations.of(context)!.buyerAddressValidation,
              ),
              const SizedBox(height: 32),

              // Property Information Section
              Text(
                AppLocalizations.of(context)!.propertyInfoProperty,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.propertyAddress,
                controller: propertyAddressController,
                validatorMessage:
                    AppLocalizations.of(context)!.propertyAddressValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.propertySize,
                controller: propertySizeController,
                validatorMessage:
                    AppLocalizations.of(context)!.propertySizeValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.propertyPrice,
                controller: propertyPriceController,
                validatorMessage:
                    AppLocalizations.of(context)!.propertyPriceValidation,
              ),
              const SizedBox(height: 32),

              // Transaction Information Section
              Text(
                AppLocalizations.of(context)!.transactionInfoProperty,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.paymentMethod,
                controller: paymentMethodController,
                validatorMessage:
                    AppLocalizations.of(context)!.paymentMethodValidation,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.saleDate,
                controller: saleDateController,
                validatorMessage:
                    AppLocalizations.of(context)!.saleDateValidation,
              ),
              const SizedBox(height: 32),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .dateEnteredSuccessfully),
                        ),
                      );
                      GoRouter.of(context).push(AppRouter.kSuccessView);
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
