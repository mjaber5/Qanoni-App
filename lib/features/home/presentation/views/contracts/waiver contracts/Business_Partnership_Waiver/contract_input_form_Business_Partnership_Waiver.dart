import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormWaiverBusinessPartnership extends StatefulWidget {
  const ContractInputFormWaiverBusinessPartnership({super.key});

  @override
  _ContractInputFormWaiverBusinessPartnershipArabicState createState() =>
      _ContractInputFormWaiverBusinessPartnershipArabicState();
}

class _ContractInputFormWaiverBusinessPartnershipArabicState
    extends State<ContractInputFormWaiverBusinessPartnership> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();
  final TextEditingController sellerAddressController = TextEditingController();
  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController buyerIdController = TextEditingController();
  final TextEditingController buyerAddressController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();
  final TextEditingController businessDetailsController = TextEditingController();
  final TextEditingController waiverReasonController = TextEditingController();
  final TextEditingController ownershipController = TextEditingController();
  final TextEditingController waiverPriceController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController waiverDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدخال معلومات عقد التنازل عن شراكة تجارية'),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'معلومات البائع',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'اسم البائع',
                controller: sellerNameController,
                validatorMessage: 'الرجاء إدخال اسم البائع',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'رقم هوية البائع',
                controller: sellerIdController,
                validatorMessage: 'الرجاء إدخال رقم هوية البائع',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'عنوان البائع',
                controller: sellerAddressController,
                validatorMessage: 'الرجاء إدخال عنوان البائع',
              ),
              const SizedBox(height: 32),

              const Text(
                'معلومات المشتري',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'اسم المشتري',
                controller: buyerNameController,
                validatorMessage: 'الرجاء إدخال اسم المشتري',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'رقم هوية المشتري',
                controller: buyerIdController,
                validatorMessage: 'الرجاء إدخال رقم هوية المشتري',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'عنوان المشتري',
                controller: buyerAddressController,
                validatorMessage: 'الرجاء إدخال عنوان المشتري',
              ),
              const SizedBox(height: 32),

              const Text(
                'معلومات الشركة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'نوع الشركة',
                controller: businessTypeController,
                validatorMessage: 'الرجاء إدخال نوع الشركة',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'تفاصيل الشراكة (أسهم، معلومات الشركة)',
                controller: businessDetailsController,
                validatorMessage: 'الرجاء إدخال تفاصيل الشراكة',
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
