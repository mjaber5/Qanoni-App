import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContractInputFormDaily extends StatefulWidget {
  const ContractInputFormDaily({super.key});

  @override
  State<ContractInputFormDaily> createState() =>
      _DailyRentalContractFormState();
}

class _DailyRentalContractFormState extends State<ContractInputFormDaily> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController landlordNameController = TextEditingController();
  final TextEditingController landlordAddressController =
      TextEditingController();
  final TextEditingController tenantNameController = TextEditingController();
  final TextEditingController tenantAddressController = TextEditingController();
  final TextEditingController propertyLocationController =
      TextEditingController();
  final TextEditingController rentValueController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.contractInputTitle),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.landlordName,
                controller: landlordNameController,
                validatorMessage:
                    AppLocalizations.of(context)!.landlordNameValidator,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.landlordAddress,
                controller: landlordAddressController,
                validatorMessage:
                    AppLocalizations.of(context)!.landlordAddressValidator,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.tenantName,
                controller: tenantNameController,
                validatorMessage:
                    AppLocalizations.of(context)!.tenantNameValidator,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.tenantAddress,
                controller: tenantAddressController,
                validatorMessage:
                    AppLocalizations.of(context)!.tenantAddressValidator,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.propertyLocation,
                controller: propertyLocationController,
                validatorMessage:
                    AppLocalizations.of(context)!.propertyLocationValidator,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.dailyRentValue,
                controller: rentValueController,
                validatorMessage:
                    AppLocalizations.of(context)!.dailyRentValueValidator,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.contractStartDate,
                controller: startDateController,
                validatorMessage:
                    AppLocalizations.of(context)!.contractStartDateValidator,
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: AppLocalizations.of(context)!.contractEndDate,
                controller: endDateController,
                validatorMessage:
                    AppLocalizations.of(context)!.contractEndDateValidator,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log('Form is valid. Proceed with saving the contract.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('تم إدخال البيانات بنجاح')),
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
