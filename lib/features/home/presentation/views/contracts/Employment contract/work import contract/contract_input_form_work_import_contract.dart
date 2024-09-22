import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormWorkImportContract extends StatefulWidget {
  const ContractInputFormWorkImportContract({super.key});

  @override
  State<ContractInputFormWorkImportContract> createState() =>
      _RecruitmentContractInputFormState();
}

class _RecruitmentContractInputFormState
    extends State<ContractInputFormWorkImportContract> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController firstPartyController =
      TextEditingController(); // الطرف الأول
  final TextEditingController firstPartyIdController =
      TextEditingController(); // رقم هوية الطرف الأول
  final TextEditingController nationalityController =
      TextEditingController(); // جنسية الطرف الأول
  final TextEditingController secondPartyController =
      TextEditingController(); // الطرف الثاني
  final TextEditingController secondPartyPassportController =
      TextEditingController(); // رقم جواز سفر الطرف الثاني
  final TextEditingController secondPartyNationalityController =
      TextEditingController(); // جنسية الطرف الثاني
  final TextEditingController jobTitleController =
      TextEditingController(); // الوظيفة
  final TextEditingController contractDurationController =
      TextEditingController(); // مدة العقد
  final TextEditingController salaryController =
      TextEditingController(); // الأجر
  final TextEditingController startDateController =
      TextEditingController(); // تاريخ بدء العقد

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدخال بيانات عقد عمل للاستقدام'),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // First Party Name
              buildLabeledTextField(
                label: 'اسم الطرف الأول',
                controller: firstPartyController,
                validatorMessage: 'يرجى إدخال اسم الطرف الأول',
              ),
              const SizedBox(height: 16),

              // First Party ID
              buildLabeledTextField(
                label: 'رقم هوية الطرف الأول',
                controller: firstPartyIdController,
                validatorMessage: 'يرجى إدخال رقم هوية الطرف الأول',
              ),
              const SizedBox(height: 16),

              // First Party Nationality
              buildLabeledTextField(
                label: 'جنسية الطرف الأول',
                controller: nationalityController,
                validatorMessage: 'يرجى إدخال جنسية الطرف الأول',
              ),
              const SizedBox(height: 16),

              // Second Party Name
              buildLabeledTextField(
                label: 'اسم الطرف الثاني',
                controller: secondPartyController,
                validatorMessage: 'يرجى إدخال اسم الطرف الثاني',
              ),
              const SizedBox(height: 16),

              // Second Party Passport
              buildLabeledTextField(
                label: 'رقم جواز سفر الطرف الثاني',
                controller: secondPartyPassportController,
                validatorMessage: 'يرجى إدخال رقم جواز سفر الطرف الثاني',
              ),
              const SizedBox(height: 16),

              // Second Party Nationality
              buildLabeledTextField(
                label: 'جنسية الطرف الثاني',
                controller: secondPartyNationalityController,
                validatorMessage: 'يرجى إدخال جنسية الطرف الثاني',
              ),
              const SizedBox(height: 16),

              // Job Title
              buildLabeledTextField(
                label: 'الوظيفة',
                controller: jobTitleController,
                validatorMessage: 'يرجى إدخال الوظيفة',
              ),
              const SizedBox(height: 16),

              // Contract Duration
              buildLabeledTextField(
                label: 'مدة العقد',
                controller: contractDurationController,
                validatorMessage: 'يرجى إدخال مدة العقد',
              ),
              const SizedBox(height: 16),

              // Salary
              buildLabeledTextField(
                label: 'الأجر',
                controller: salaryController,
                validatorMessage: 'يرجى إدخال الأجر',
              ),
              const SizedBox(height: 16),

              // Start Date
              buildLabeledTextField(
                label: 'تاريخ بدء العقد',
                controller: startDateController,
                validatorMessage: 'يرجى إدخال تاريخ بدء العقد',
              ),
              const SizedBox(height: 32),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log('تم إدخال البيانات بنجاح.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('تم إدخال البيانات بنجاح')),
                      );
                    } else {
                      log('البيانات غير صحيحة. يرجى التحقق.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: const Text(
                    "حفظ",
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
