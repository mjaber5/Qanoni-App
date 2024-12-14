import 'package:flutter/material.dart';

class WitnessInfoForm extends StatefulWidget {
  const WitnessInfoForm({super.key});

  @override
  _WitnessInfoFormState createState() => _WitnessInfoFormState();
}

class _WitnessInfoFormState extends State<WitnessInfoForm> {
  final TextEditingController witnessNameController = TextEditingController();
  final TextEditingController witnessIDController = TextEditingController();
  final TextEditingController witnessAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معلومات الشاهد'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Text fields for witness data
              _buildTextField('اسم الشاهد', witnessNameController),
              _buildTextField('رقم هوية الشاهد', witnessIDController),
              _buildTextField('مكان إقامة الشاهد', witnessAddressController),
              const SizedBox(height: 20),
              // Save Button
              ElevatedButton(
                onPressed: () {
                  // هنا يمكنك إضافة الكود لمعالجة البيانات المدخلة، مثل حفظ البيانات
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حفظ بيانات الشاهد')),
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
    witnessNameController.dispose();
    witnessIDController.dispose();
    witnessAddressController.dispose();
    super.dispose();
  }
}
