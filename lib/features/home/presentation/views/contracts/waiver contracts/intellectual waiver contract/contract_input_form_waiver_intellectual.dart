import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormWaiverIntellectual extends StatefulWidget {
  const ContractInputFormWaiverIntellectual({super.key});

  @override
  _ContractInputFormWaiverIntellectualArabicState createState() =>
      _ContractInputFormWaiverIntellectualArabicState();
}

class _ContractInputFormWaiverIntellectualArabicState
    extends State<ContractInputFormWaiverIntellectual> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController ownerIdController = TextEditingController();
  final TextEditingController ownerAddressController = TextEditingController();
  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController receiverIdController = TextEditingController();
  final TextEditingController receiverAddressController = TextEditingController();
  final TextEditingController intellectualPropertyTypeController = TextEditingController();
  final TextEditingController intellectualPropertyDetailsController = TextEditingController();
  final TextEditingController waiverReasonController = TextEditingController();
  final TextEditingController ownershipController = TextEditingController();
  final TextEditingController waiverPriceController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController waiverDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدخال معلومات عقد التنازل عن حقوق فكرية'),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'معلومات المالك',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'اسم المالك',
                controller: ownerNameController,
                validatorMessage: 'الرجاء إدخال اسم المالك',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'رقم هوية المالك',
                controller: ownerIdController,
                validatorMessage: 'الرجاء إدخال رقم هوية المالك',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'عنوان المالك',
                controller: ownerAddressController,
                validatorMessage: 'الرجاء إدخال عنوان المالك',
              ),
              const SizedBox(height: 32),

              const Text(
                'معلومات المستلم',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'اسم المستلم',
                controller: receiverNameController,
                validatorMessage: 'الرجاء إدخال اسم المستلم',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'رقم هوية المستلم',
                controller: receiverIdController,
                validatorMessage: 'الرجاء إدخال رقم هوية المستلم',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'عنوان المستلم',
                controller: receiverAddressController,
                validatorMessage: 'الرجاء إدخال عنوان المستلم',
              ),
              const SizedBox(height: 32),

              const Text(
                'معلومات حقوق الملكية الفكرية',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'نوع الملكية الفكرية',
                controller: intellectualPropertyTypeController,
                validatorMessage: 'الرجاء إدخال نوع الملكية الفكرية',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'تفاصيل الملكية الفكرية',
                controller: intellectualPropertyDetailsController,
                validatorMessage: 'الرجاء إدخال تفاصيل الملكية الفكرية',
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
                      log('نموذج صالح. حفظ البيانات.');
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
