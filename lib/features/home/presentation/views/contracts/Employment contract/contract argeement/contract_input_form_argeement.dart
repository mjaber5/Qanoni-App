import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormArgeement extends StatefulWidget {
  const ContractInputFormArgeement({super.key});

  @override
  State<ContractInputFormArgeement> createState() => _ContractInputFormState();
}

class _ContractInputFormState extends State<ContractInputFormArgeement> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController projectNameController =
      TextEditingController(); // اسم المشروع
  final TextEditingController projectOwnerNameController =
      TextEditingController(); // اسم صاحب المشروع
  final TextEditingController projectOwnerIdController =
      TextEditingController(); // رقم هوية صاحب المشروع
  final TextEditingController contractorNameController =
      TextEditingController(); // اسم المقاول
  final TextEditingController contractorIdController =
      TextEditingController(); // رقم هوية المقاول
  final TextEditingController contractDurationController =
      TextEditingController(); // مدة العقد
  final TextEditingController contractValueController =
      TextEditingController(); // قيمة العقد الإجمالية
  final TextEditingController materialsProvidedController =
      TextEditingController(); // المواد والمعدات
  final TextEditingController startDateController =
      TextEditingController(); // تاريخ بدء العقد

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدخال بيانات عقد مقاولات'),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Project Name
              buildLabeledTextField(
                label: 'اسم المشروع',
                controller: projectNameController,
                validatorMessage: 'يرجى إدخال اسم المشروع',
              ),
              const SizedBox(height: 16),

              // Project Owner Name
              buildLabeledTextField(
                label: 'اسم صاحب المشروع',
                controller: projectOwnerNameController,
                validatorMessage: 'يرجى إدخال اسم صاحب المشروع',
              ),
              const SizedBox(height: 16),

              // Project Owner ID
              buildLabeledTextField(
                label: 'رقم هوية صاحب المشروع',
                controller: projectOwnerIdController,
                validatorMessage: 'يرجى إدخال رقم هوية صاحب المشروع',
              ),
              const SizedBox(height: 16),

              // Contractor Name
              buildLabeledTextField(
                label: 'اسم المقاول',
                controller: contractorNameController,
                validatorMessage: 'يرجى إدخال اسم المقاول',
              ),
              const SizedBox(height: 16),

              // Contractor ID
              buildLabeledTextField(
                label: 'رقم هوية المقاول',
                controller: contractorIdController,
                validatorMessage: 'يرجى إدخال رقم هوية المقاول',
              ),
              const SizedBox(height: 16),

              // Contract Duration
              buildLabeledTextField(
                label: 'مدة العقد',
                controller: contractDurationController,
                validatorMessage: 'يرجى إدخال مدة العقد',
              ),
              const SizedBox(height: 16),

              // Contract Value
              buildLabeledTextField(
                label: 'قيمة العقد الإجمالية',
                controller: contractValueController,
                validatorMessage: 'يرجى إدخال قيمة العقد',
              ),
              const SizedBox(height: 16),

              // Materials and Equipment
              buildLabeledTextField(
                label: 'المواد والمعدات',
                controller: materialsProvidedController,
                validatorMessage: 'يرجى إدخال المواد والمعدات اللازمة',
              ),
              const SizedBox(height: 16),

              // Contract Start Date
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
