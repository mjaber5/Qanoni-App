import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormPublicServic extends StatefulWidget {
  const ContractInputFormPublicServic({super.key});

  @override
  _ServiceContractInputFormState createState() => _ServiceContractInputFormState();
}

class _ServiceContractInputFormState extends State<ContractInputFormPublicServic> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController firstPartyController = TextEditingController();   
  final TextEditingController secondPartyController = TextEditingController();   
  final TextEditingController serviceDescriptionController = TextEditingController();   
  final TextEditingController contractDurationController = TextEditingController();   
  final TextEditingController serviceFeeController = TextEditingController();   
  final TextEditingController startDateController = TextEditingController();    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدخال بيانات عقد خدمات عامة'),
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

              // Second Party Name
              buildLabeledTextField(
                label: 'اسم الطرف الثاني',
                controller: secondPartyController,
                validatorMessage: 'يرجى إدخال اسم الطرف الثاني',
              ),
              const SizedBox(height: 16),

              // Service Description
              buildLabeledTextField(
                label: 'وصف الخدمة',
                controller: serviceDescriptionController,
                validatorMessage: 'يرجى إدخال وصف الخدمة',
              ),
              const SizedBox(height: 16),

              // Contract Duration
              buildLabeledTextField(
                label: 'مدة العقد',
                controller: contractDurationController,
                validatorMessage: 'يرجى إدخال مدة العقد',
              ),
              const SizedBox(height: 16),

              // Service Fee
              buildLabeledTextField(
                label: 'المقابل المالي',
                controller: serviceFeeController,
                validatorMessage: 'يرجى إدخال المقابل المالي',
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
