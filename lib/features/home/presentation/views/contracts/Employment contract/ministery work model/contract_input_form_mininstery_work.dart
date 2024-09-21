import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormMininsteryWork extends StatefulWidget {
  const ContractInputFormMininsteryWork({super.key});

  @override
  _MinistryLaborContractFormState createState() => _MinistryLaborContractFormState();
}

class _MinistryLaborContractFormState extends State<ContractInputFormMininsteryWork> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController firstPartyController = TextEditingController(); // الطرف الأول (الشركة)
  final TextEditingController legalRepController = TextEditingController(); // الممثل القانوني
  final TextEditingController commercialRegisterController = TextEditingController(); // السجل التجاري
  final TextEditingController firstPartyAddressController = TextEditingController(); // عنوان الطرف الأول
  final TextEditingController firstPartyPhoneController = TextEditingController(); // هاتف الطرف الأول
  final TextEditingController secondPartyController = TextEditingController(); // الطرف الثاني (الموظف)
  final TextEditingController nationalityController = TextEditingController(); // جنسية الطرف الثاني
  final TextEditingController idController = TextEditingController(); // رقم الهوية/الإقامة للطرف الثاني
  final TextEditingController secondPartyAddressController = TextEditingController(); // عنوان الطرف الثاني
  final TextEditingController secondPartyPhoneController = TextEditingController(); // هاتف الطرف الثاني
  final TextEditingController jobTitleController = TextEditingController(); // الوظيفة
  final TextEditingController contractDurationController = TextEditingController(); // مدة العقد
  final TextEditingController salaryController = TextEditingController(); // الأجر الشهري
  final TextEditingController startDateController = TextEditingController(); // تاريخ بدء العقد

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدخال بيانات عقد عمل - وزارة العمل'),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // First Party (Company) Name
              buildLabeledTextField(
                label: 'اسم الطرف الأول (الشركة)',
                controller: firstPartyController,
                validatorMessage: 'يرجى إدخال اسم الطرف الأول',
              ),
              const SizedBox(height: 16),

              // Legal Representative
              buildLabeledTextField(
                label: 'الممثل القانوني',
                controller: legalRepController,
                validatorMessage: 'يرجى إدخال اسم الممثل القانوني',
              ),
              const SizedBox(height: 16),

              // Commercial Register
              buildLabeledTextField(
                label: 'السجل التجاري',
                controller: commercialRegisterController,
                validatorMessage: 'يرجى إدخال السجل التجاري',
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

              // Second Party (Employee) Name
              buildLabeledTextField(
                label: 'اسم الطرف الثاني (الموظف)',
                controller: secondPartyController,
                validatorMessage: 'يرجى إدخال اسم الطرف الثاني',
              ),
              const SizedBox(height: 16),

              // Nationality
              buildLabeledTextField(
                label: 'جنسية الطرف الثاني',
                controller: nationalityController,
                validatorMessage: 'يرجى إدخال جنسية الطرف الثاني',
              ),
              const SizedBox(height: 16),

              // ID / Residence Number
              buildLabeledTextField(
                label: 'رقم الهوية/الإقامة',
                controller: idController,
                validatorMessage: 'يرجى إدخال رقم الهوية أو الإقامة',
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

              // Contract Duration
              buildLabeledTextField(
                label: 'مدة العقد',
                controller: contractDurationController,
                validatorMessage: 'يرجى إدخال مدة العقد',
              ),
              const SizedBox(height: 16),

              // Salary
              buildLabeledTextField(
                label: 'الأجر الشهري',
                controller: salaryController,
                validatorMessage: 'يرجى إدخال الأجر الشهري',
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
                        const SnackBar(content: Text('تم إدخال البيانات بنجاح')),
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
