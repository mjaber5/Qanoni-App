import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormLand extends StatefulWidget {
  const ContractInputFormLand({super.key});

  @override
  State<ContractInputFormLand> createState() =>
      _ContractInputFormLandState();
}

class _ContractInputFormLandState extends State<ContractInputFormLand> {
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
        title: Text(AppLocalizations.of(context)!.landSaleContractInfoAppBar),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // 1. تاريخ
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.dateLabel,
                controller: dateController,
                validatorMessage: AppLocalizations.of(context)!.validatoreMessageEnterDate,
              ),
              const SizedBox(height: 16),

              // 2. معلومات البائع والمشتري
              Text(
                AppLocalizations.of(context)!.paritesInformation,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.sellerName,
                controller: sellerNameController,
                validatorMessage: AppLocalizations.of(context)!.sellerNameValidatoreMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.sellerAddress,
                controller: sellerAddressController,
                validatorMessage: AppLocalizations.of(context)!.sellerAddressValidatoreMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.buyerName,
                controller: buyerNameController,
                validatorMessage: AppLocalizations.of(context)!.buyerNameValidatorMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.buyerAddress,
                controller: buyerAddressController,
                validatorMessage: AppLocalizations.of(context)!.buyerAddressValidatorMessage,
              ),
              const SizedBox(height: 32),

              // 3. تفاصيل العقار
              Text(
                AppLocalizations.of(context)!.propertyDetails,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.propertyType,
                controller: propertyTypeController,
                validatorMessage: AppLocalizations.of(context)!.propertyTypeValidatorMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.propertyNumber,
                controller: propertyNumberController,
                validatorMessage: AppLocalizations.of(context)!.propertyNumberValidatorMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.parcelNumber,
                controller: landParcelNumberController,
                validatorMessage: AppLocalizations.of(context)!.parcelNumberValidatorMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.landArea,
                controller: landAreaController,
                validatorMessage: AppLocalizations.of(context)!.landAreaValidatorMessage,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.apartmentNumber,
                controller: apartmentNumberController,
                validatorMessage: AppLocalizations.of(context)!.apartmentNumberValidatorMessage,
              ),
              const SizedBox(height: 32),

              // 4. سعر العقار
              Text(
                AppLocalizations.of(context)!.propertyPrice,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.amountLabel,
                controller: priceController,
                validatorMessage: AppLocalizations.of(context)!.amountLabelValidatorMessage,
              ),
              const SizedBox(height: 32),

              // زر الإرسال
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!.dateEnteredSuccessfuly),
                        ),
                      );
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

  // دالة مساعدة لبناء حقل نصي مع تسمية
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
