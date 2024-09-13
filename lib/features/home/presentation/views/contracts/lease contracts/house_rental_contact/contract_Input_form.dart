import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputForm extends StatefulWidget {
  const ContractInputForm({super.key});

  @override
  _ContractInputFormState createState() => _ContractInputFormState();
}

class _ContractInputFormState extends State<ContractInputForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController landlordNameController = TextEditingController();
  final TextEditingController landlordIdController = TextEditingController();
  final TextEditingController tenantNameController = TextEditingController();
  final TextEditingController tenantIdController = TextEditingController();
  final TextEditingController rentAmountController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController contractDurationController = TextEditingController();
  final TextEditingController propertyAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدخال معلومات عقد الإيجار'),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Landlord Name
              AppTextFormField(
                controller: landlordNameController,
                hintText: 'اسم المؤجر',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال اسم المؤجر';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Landlord ID
              AppTextFormField(
                controller: landlordIdController,
                hintText: 'رقم بطاقة المؤجر',
                
                // keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال رقم بطاقة المؤجر';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Tenant Name
              AppTextFormField(
                controller: tenantNameController,
                hintText: 'اسم المستأجر',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال اسم المستأجر';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Tenant ID
              AppTextFormField(
                controller: tenantIdController,
                hintText: 'رقم بطاقة المستأجر',
                // keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال رقم بطاقة المستأجر';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Property Address
              AppTextFormField(
                controller: propertyAddressController,
                hintText: 'عنوان العقار',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال عنوان العقار';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Rent Amount
              AppTextFormField(
                controller: rentAmountController,
                hintText: 'مبلغ الإيجار',
                // keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال مبلغ الإيجار';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Contract Start Date
              AppTextFormField(
                controller: startDateController,
                hintText: 'تاريخ بداية العقد',
                // keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال تاريخ بداية العقد';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Contract Duration
              AppTextFormField(
                controller: contractDurationController,
                hintText: 'مدة العقد',
                // keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال مدة العقد';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log('Form is valid. Proceed with saving the contract.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم إدخال البيانات بنجاح')),
                      );
                    } else {
                      log('Form is not valid. Show errors.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: const Text(
                    "Save",
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
}
