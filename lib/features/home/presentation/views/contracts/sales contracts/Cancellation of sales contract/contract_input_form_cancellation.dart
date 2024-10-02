import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormEquipment extends StatefulWidget {
  const ContractInputFormEquipment({super.key});

  @override
  State<ContractInputFormEquipment> createState() =>
      _ContractInputFormEquipmentState();
}

class _ContractInputFormEquipmentState
    extends State<ContractInputFormEquipment> {
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
        title: const Text(QTexts.appBarTitleEquipment),
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
        const Text(
          QTexts.partiesInfo,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        buildLabeledTextField(
          label: QTexts.vendorName,
          controller: vendorNameController,
          validatorMessage: QTexts.vendorNameValidation,
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: QTexts.vendorAddress,
          controller: vendorAddressController,
          validatorMessage: QTexts.vendorAddressValidation,
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: QTexts.purchaserName,
          controller: purchaserNameController,
          validatorMessage: QTexts.purchaserNameValidation,
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: QTexts.purchaserAddress,
          controller: purchaserAddressController,
          validatorMessage: QTexts.purchaserAddressValidation,
        ),
      ],
    );
  }

  Widget buildEquipmentDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          QTexts.equipmentDetails,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        buildLabeledTextField(
          label: QTexts.equipmentType,
          controller: equipmentTypeController,
          validatorMessage: QTexts.equipmentTypeValidation,
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: QTexts.equipmentModel,
          controller: equipmentModelController,
          validatorMessage: QTexts.equipmentModelValidation,
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: QTexts.equipmentSerialNumber,
          controller: equipmentSerialNumberController,
          validatorMessage: QTexts.equipmentSerialNumberValidation,
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: QTexts.equipmentCondition,
          controller: equipmentConditionController,
          validatorMessage: QTexts.equipmentConditionValidation,
        ),
      ],
    );
  }

  Widget buildSaleDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          QTexts.saleDetails,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        buildLabeledTextField(
          label: QTexts.price,
          controller: priceController,
          validatorMessage: QTexts.priceValidation,
        ),
        const SizedBox(height: 16),
        buildLabeledTextField(
          label: QTexts.saleDate,
          controller: saleDateController,
          validatorMessage: QTexts.saleDateValidation,
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
              const SnackBar(
                  content: Text(QTexts.dateEnteredSuccessfuly)),
            );
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
