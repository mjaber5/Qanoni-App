import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormWaiverLegalFinancialArabic extends StatefulWidget {
  const ContractInputFormWaiverLegalFinancialArabic({super.key});

  @override
  State<ContractInputFormWaiverLegalFinancialArabic> createState() =>
      _ContractInputFormWaiverLegalFinancialArabicState();
}

class _ContractInputFormWaiverLegalFinancialArabicState
    extends State<ContractInputFormWaiverLegalFinancialArabic> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController rightsHolderNameController =
      TextEditingController();
  final TextEditingController rightsHolderIdController =
      TextEditingController();
  final TextEditingController rightsHolderAddressController =
      TextEditingController();
  final TextEditingController transfereeNameController =
      TextEditingController();
  final TextEditingController transfereeIdController = TextEditingController();
  final TextEditingController transfereeAddressController =
      TextEditingController();
  final TextEditingController rightsTypeController = TextEditingController();
  final TextEditingController rightsDetailsController = TextEditingController();
  final TextEditingController waiverReasonController = TextEditingController();
  final TextEditingController waiverPriceController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController waiverDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'إدخال معلومات عقد التنازل عن الحقوق القانونية أو المالية'),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'معلومات حامل الحقوق',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'اسم حامل الحقوق',
                controller: rightsHolderNameController,
                validatorMessage: 'الرجاء إدخال اسم حامل الحقوق',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'رقم هوية حامل الحقوق',
                controller: rightsHolderIdController,
                validatorMessage: 'الرجاء إدخال رقم هوية حامل الحقوق',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'عنوان حامل الحقوق',
                controller: rightsHolderAddressController,
                validatorMessage: 'الرجاء إدخال عنوان حامل الحقوق',
              ),
              const SizedBox(height: 32),
              const Text(
                'معلومات المستلم',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'اسم المستلم',
                controller: transfereeNameController,
                validatorMessage: 'الرجاء إدخال اسم المستلم',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'رقم هوية المستلم',
                controller: transfereeIdController,
                validatorMessage: 'الرجاء إدخال رقم هوية المستلم',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'عنوان المستلم',
                controller: transfereeAddressController,
                validatorMessage: 'الرجاء إدخال عنوان المستلم',
              ),
              const SizedBox(height: 32),
              const Text(
                'معلومات الحقوق',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'نوع الحقوق (قانونية / مالية)',
                controller: rightsTypeController,
                validatorMessage: 'الرجاء إدخال نوع الحقوق',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'تفاصيل الحقوق',
                controller: rightsDetailsController,
                validatorMessage: 'الرجاء إدخال تفاصيل الحقوق',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'سبب التنازل',
                controller: waiverReasonController,
                validatorMessage: 'الرجاء إدخال سبب التنازل',
              ),
              const SizedBox(height: 32),
              const Text(
                'معلومات المعاملة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'سعر التنازل',
                controller: waiverPriceController,
                validatorMessage: 'الرجاء إدخال سعر التنازل',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'طريقة الدفع',
                controller: paymentMethodController,
                validatorMessage: 'الرجاء إدخال طريقة الدفع',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'تاريخ التنازل',
                controller: waiverDateController,
                validatorMessage: 'الرجاء إدخال تاريخ التنازل',
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log('النموذج صالح. حفظ البيانات.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('تم إدخال البيانات بنجاح')),
                      );
                    } else {
                      log('النموذج غير صالح. إظهار الأخطاء.');
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
