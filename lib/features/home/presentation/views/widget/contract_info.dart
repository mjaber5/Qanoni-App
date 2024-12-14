import 'package:flutter/material.dart';

class ContractInfoForm extends StatefulWidget {
  const ContractInfoForm({super.key});

  @override
  _ContractInfoFormState createState() => _ContractInfoFormState();
}

class _ContractInfoFormState extends State<ContractInfoForm> {
  final TextEditingController contractDateController = TextEditingController();
  final TextEditingController contractPlaceController = TextEditingController();
  final TextEditingController saleAmountController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController ownershipTransferController = TextEditingController();
  final TextEditingController additionalTermsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بيانات العقد'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Text fields for contract data
              _buildTextField('تاريخ العقد', contractDateController),
              _buildTextField('مكان توقيع العقد', contractPlaceController),
              _buildTextField('قيمة البيع', saleAmountController),
              _buildTextField('طريقة الدفع', paymentMethodController),
              _buildTextField('التزام الطرفين بنقل الملكية قانونياً', ownershipTransferController),
              _buildTextField('شروط إضافية', additionalTermsController),
              const SizedBox(height: 20),
              // Save Button
              ElevatedButton(
                onPressed: () {
                  // هنا يمكنك إضافة الكود لمعالجة البيانات المدخلة، مثل حفظ البيانات
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حفظ بيانات العقد')),
                  );
                },
                child: const Text('حفظ البيانات'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the text controllers to avoid memory leaks
    contractDateController.dispose();
    contractPlaceController.dispose();
    saleAmountController.dispose();
    paymentMethodController.dispose();
    ownershipTransferController.dispose();
    additionalTermsController.dispose();
    super.dispose();
  }
}
