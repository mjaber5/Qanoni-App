import 'package:flutter/material.dart';
import 'package:qanoni/features/home/data/contract_repo.dart';

import '../../../../../core/utils/constants/colors.dart';

class ContractInfoForm extends StatefulWidget {
  const ContractInfoForm({super.key});

  @override
  State<ContractInfoForm> createState() => _ContractInfoFormState();
}

class _ContractInfoFormState extends State<ContractInfoForm> {
  final TextEditingController contractDateController = TextEditingController();
  final TextEditingController contractPlaceController = TextEditingController();
  final TextEditingController saleAmountController = TextEditingController();
  final TextEditingController ownershipTransferController =
      TextEditingController();
  final TextEditingController additionalTermsController =
      TextEditingController();

  // متغيرات لحفظ حالة مربع الاختيار
  bool ownershipTransferChecked = false;

  // قائمة طرق الدفع
  String? selectedPaymentMethod;

  void submitContractInfo() {
    final contractRepo = ContractRepo();
    final contractInfo = contractRepo.createContractInfo(
      contractDate: contractDateController.text,
      contractPlace: contractPlaceController.text,
      saleAmount: saleAmountController.text,
      paymentMethod: selectedPaymentMethod ?? 'online',
      ownershipTransfer: ownershipTransferChecked,
      additionalTerms: additionalTermsController.text,
    );

    contractRepo.saveContract(contractInfo: contractInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بيانات العقد'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text fields for contract data
              _buildTextField('تاريخ العقد', contractDateController),
              _buildTextField('مكان توقيع العقد', contractPlaceController),
              _buildTextField('قيمة البيع', saleAmountController),

              // Spinner for payment method
              _buildPaymentMethodDropdown(),

              // Checkbox for ownership transfer
              _buildOwnershipTransferCheckbox(),

              _buildTextField('شروط إضافية', additionalTermsController),
              const SizedBox(height: 20),

              // Save Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    submitContractInfo();
                    // هنا يمكنك إضافة الكود لمعالجة البيانات المدخلة، مثل حفظ البيانات
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم حفظ بيانات العقد')),
                    );
                  },
                  child: const Text(
                    'حفظ البيانات',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: QColors.secondary),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildPaymentMethodDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: DropdownButtonFormField<String>(
        value: selectedPaymentMethod,
        decoration: const InputDecoration(
          labelText: 'طريقة الدفع',
          labelStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
          border: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: QColors.secondary),
          ),
        ),
        items: [
          'نقداً',
          'تحويل بنكي',
          'بطاقة ائتمان',
          'دفع عبر الإنترنت',
        ].map((method) {
          return DropdownMenuItem<String>(
            value: method,
            child: Text(method),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedPaymentMethod = value;
          });
        },
      ),
    );
  }

  Widget _buildOwnershipTransferCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Checkbox(
            value: ownershipTransferChecked,
            onChanged: (bool? value) {
              setState(() {
                ownershipTransferChecked = value ?? false;
              });
            },
          ),
          const Expanded(child: Text('التزام الطرفين بنقل الملكية قانونياً')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the text controllers to avoid memory leaks
    contractDateController.dispose();
    contractPlaceController.dispose();
    saleAmountController.dispose();
    additionalTermsController.dispose();
    super.dispose();
  }
}
