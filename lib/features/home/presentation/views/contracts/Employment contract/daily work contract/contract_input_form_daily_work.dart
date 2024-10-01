import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../../../core/widgets/app_text_form_field.dart';

class ContractInputFormDailyWork extends StatefulWidget {
  const ContractInputFormDailyWork({super.key});

  @override
  State<ContractInputFormDailyWork> createState() =>
      _DailyContractInputFormState();
}

class _DailyContractInputFormState extends State<ContractInputFormDailyWork> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController firstPartyNameController =
      TextEditingController(); // اسم الطرف الأول
  final TextEditingController firstPartyIdController =
      TextEditingController(); // رقم هوية/السجل التجاري للطرف الأول
  final TextEditingController firstPartyAddressController =
      TextEditingController(); // عنوان الطرف الأول
  final TextEditingController firstPartyPhoneController =
      TextEditingController(); // هاتف الطرف الأول
  final TextEditingController secondPartyNameController =
      TextEditingController(); // اسم الطرف الثاني
  final TextEditingController secondPartyIdController =
      TextEditingController(); // رقم الهوية للطرف الثاني
  final TextEditingController secondPartyNationalityController =
      TextEditingController(); // جنسية الطرف الثاني
  final TextEditingController secondPartyAddressController =
      TextEditingController(); // عنوان الطرف الثاني
  final TextEditingController secondPartyPhoneController =
      TextEditingController(); // هاتف الطرف الثاني
  final TextEditingController jobTitleController =
      TextEditingController(); // الوظيفة
  final TextEditingController contractStartDateController =
      TextEditingController(); // تاريخ بدء العمل
  final TextEditingController dailyWageController =
      TextEditingController(); // الأجر اليومي
  final TextEditingController workingHoursController =
      TextEditingController(); // ساعات العمل
  final TextEditingController breakDurationController =
      TextEditingController(); // مدة الاستراحة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدخال بيانات عقد عمل مياومة'),
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
                label: 'اسم الطرف الأول (صاحب العمل)',
                controller: firstPartyNameController,
                validatorMessage: 'يرجى إدخال اسم الطرف الأول',
              ),
              const SizedBox(height: 16),

              // First Party ID / Commercial Record
              buildLabeledTextField(
                label: 'رقم هوية/السجل التجاري للطرف الأول',
                controller: firstPartyIdController,
                validatorMessage: 'يرجى إدخال رقم الهوية أو السجل التجاري',
              ),
              const SizedBox(height: 16),

              // First Party Address
              buildLabeledTextField(
                label: 'عنوان الطرف الأول',
                controller: firstPartyAddressController,
                validatorMessage: 'يرجى إدخال عنوان الطرف الأول',
              ),
              const SizedBox(height: 16),

              // First Party Phone
              buildLabeledTextField(
                label: 'هاتف الطرف الأول',
                controller: firstPartyPhoneController,
                validatorMessage: 'يرجى إدخال هاتف الطرف الأول',
              ),
              const SizedBox(height: 16),

              // Second Party Name
              buildLabeledTextField(
                label: 'اسم الطرف الثاني (العامل)',
                controller: secondPartyNameController,
                validatorMessage: 'يرجى إدخال اسم الطرف الثاني',
              ),
              const SizedBox(height: 16),

              // Second Party ID
              buildLabeledTextField(
                label: 'رقم الهوية للطرف الثاني',
                controller: secondPartyIdController,
                validatorMessage: 'يرجى إدخال رقم الهوية للطرف الثاني',
              ),
              const SizedBox(height: 16),

              // Second Party Nationality
              buildLabeledTextField(
                label: 'جنسية الطرف الثاني',
                controller: secondPartyNationalityController,
                validatorMessage: 'يرجى إدخال جنسية الطرف الثاني',
              ),
              const SizedBox(height: 16),

              // Second Party Address
              buildLabeledTextField(
                label: 'عنوان الطرف الثاني',
                controller: secondPartyAddressController,
                validatorMessage: 'يرجى إدخال عنوان الطرف الثاني',
              ),
              const SizedBox(height: 16),

              // Second Party Phone
              buildLabeledTextField(
                label: 'هاتف الطرف الثاني',
                controller: secondPartyPhoneController,
                validatorMessage: 'يرجى إدخال هاتف الطرف الثاني',
              ),
              const SizedBox(height: 16),

              // Job Title
              buildLabeledTextField(
                label: 'الوظيفة',
                controller: jobTitleController,
                validatorMessage: 'يرجى إدخال الوظيفة',
              ),
              const SizedBox(height: 16),

              // Contract Start Date
              buildLabeledTextField(
                label: 'تاريخ بدء العمل',
                controller: contractStartDateController,
                validatorMessage: 'يرجى إدخال تاريخ بدء العمل',
              ),
              const SizedBox(height: 16),

              // Daily Wage
              buildLabeledTextField(
                label: 'الأجر اليومي',
                controller: dailyWageController,
                validatorMessage: 'يرجى إدخال الأجر اليومي',
              ),
              const SizedBox(height: 16),

              // Working Hours
              buildLabeledTextField(
                label: 'ساعات العمل',
                controller: workingHoursController,
                validatorMessage: 'يرجى إدخال ساعات العمل',
              ),
              const SizedBox(height: 16),

              // Break Duration
              buildLabeledTextField(
                label: 'مدة الاستراحة',
                controller: breakDurationController,
                validatorMessage: 'يرجى إدخال مدة الاستراحة',
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
