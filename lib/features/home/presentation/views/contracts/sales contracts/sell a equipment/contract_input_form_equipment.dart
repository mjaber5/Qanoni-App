import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import localization package
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormEquipmentt extends StatefulWidget {
  const ContractInputFormEquipmentt({super.key});

  @override
  State<ContractInputFormEquipmentt> createState() =>
      _ContractInputFormEquipmentState();
}

class _ContractInputFormEquipmentState
    extends State<ContractInputFormEquipmentt> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController vendorNameController = TextEditingController();
  final TextEditingController vendorAddressController = TextEditingController();
  final TextEditingController purchaserNameController = TextEditingController();
  final TextEditingController purchaserAddressController =
      TextEditingController();
  final TextEditingController equipmentTypeController = TextEditingController();
  final TextEditingController equipmentModelController =
      TextEditingController();
  final TextEditingController equipmentSerialNumberController =
      TextEditingController();
  final TextEditingController equipmentConditionController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController saleDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appBarTitleEquipment), // Use localization here
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildPartiesInfoSection(),
              const SizedBox(height: 32),
              buildEquipmentDetailsSection(),
              const SizedBox(height: 32),
              buildSaleDetailsSection(),
              const SizedBox(height: 32),
              buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPartiesInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.partiesInfo, // Use localization here
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        buildLabeledTextField(
          label: AppLocalizations.of(context)!.vendorName, // Use localization here
          controller: vendorNameController,
          validatorMessage: AppLocalizations.of(context)!.vendorNameValidation, // Use localization here
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: AppLocalizations.of(context)!.vendorAddress, // Use localization here
          controller: vendorAddressController,
          validatorMessage: AppLocalizations.of(context)!.vendorAddressValidation, // Use localization here
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: AppLocalizations.of(context)!.purchaserName, // Use localization here
          controller: purchaserNameController,
          validatorMessage: AppLocalizations.of(context)!.purchaserNameValidation, // Use localization here
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: AppLocalizations.of(context)!.purchaserAddress, // Use localization here
          controller: purchaserAddressController,
          validatorMessage: AppLocalizations.of(context)!.purchaserAddressValidation, // Use localization here
        ),
      ],
    );
  }

  Widget buildEquipmentDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.equipmentDetails, // Use localization here
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        buildLabeledTextField(
          label: AppLocalizations.of(context)!.equipmentType, // Use localization here
          controller: equipmentTypeController,
          validatorMessage: AppLocalizations.of(context)!.equipmentTypeValidation, // Use localization here
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: AppLocalizations.of(context)!.equipmentModel, // Use localization here
          controller: equipmentModelController,
          validatorMessage: AppLocalizations.of(context)!.equipmentModelValidation, // Use localization here
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: AppLocalizations.of(context)!.equipmentSerialNumber, // Use localization here
          controller: equipmentSerialNumberController,
          validatorMessage: AppLocalizations.of(context)!.equipmentSerialNumberValidation, // Use localization here
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: AppLocalizations.of(context)!.equipmentCondition, // Use localization here
          controller: equipmentConditionController,
          validatorMessage: AppLocalizations.of(context)!.equipmentConditionValidation, // Use localization here
        ),
      ],
    );
  }

  Widget buildSaleDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.saleDetails, // Use localization here
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        buildLabeledTextField(
          label: AppLocalizations.of(context)!.price, // Use localization here
          controller: priceController,
          validatorMessage: AppLocalizations.of(context)!.priceValidation, // Use localization here
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: AppLocalizations.of(context)!.saleDate, // Use localization here
          controller: saleDateController,
          validatorMessage: AppLocalizations.of(context)!.saleDateValidation, // Use localization here
        ),
      ],
    );
  }

  Widget buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.dateEnteredSuccessfully), // Use localization here
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: QColors.secondary,
        ),
        child: Text(
          AppLocalizations.of(context)!.saveButton, // Use localization here
          style: Styles.textStyle18,
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
