import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:signature/signature.dart';

class ContractInfoForm extends StatefulWidget {
  const ContractInfoForm({super.key});

  @override
  State<ContractInfoForm> createState() => _ContractInfoFormState();
}

class _ContractInfoFormState extends State<ContractInfoForm> {
  final TextEditingController contractDateController = TextEditingController();
  final TextEditingController saleAmountController = TextEditingController();
  final TextEditingController additionalTermsController =
      TextEditingController();

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  // Variables to save checkbox state
  bool ownershipTransferChecked = false;

  // Payment methods dropdown list
  String? selectedPaymentMethod;

  // Signature placeholder URL
  String? _signatureUrl;

  // Backend Base URL
  final String baseUrl =
      'http://localhost:8080'; // Replace with your backend URL

  // Contract ID (if available)
  String? contractId;

  @override
  void initState() {
    super.initState();
    // Set the current date and time on the contractDateController
    final now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(now);
    contractDateController.text = formattedDate;
  }

  Future<void> _captureSignature(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign the Contract'),
        content: SizedBox(
          height: 300,
          width: 300,
          child: Signature(
            controller: _signatureController,
            backgroundColor: Colors.grey[200]!,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _signatureController.clear();
              Navigator.of(context).pop();
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () async {
              if (_signatureController.isNotEmpty) {
                final signature = await _signatureController.toPngBytes();
                if (signature != null) {
                  // Replace with actual upload logic if needed
                  setState(() {
                    _signatureUrl = 'User Signature Captured'; // Placeholder
                  });
                }
              }
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // Submit contract info to the backend
  Future<void> submitContractInfo() async {
    final contractData = {
      'contractDate': contractDateController.text,
      'contractPlace': _signatureUrl ?? 'No Signature',
      'saleAmount': saleAmountController.text,
      'paymentMethod': selectedPaymentMethod ?? 'online',
      'ownershipTransfer': ownershipTransferChecked,
      'additionalTerms': additionalTermsController.text,
    };

    final data = {
      'stage': 'contract',
      'contractData': contractData,
      'contractId': contractId, // Include contract ID if exists
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/save-data'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        contractId = responseData['contractId']; // Update contract ID
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Contract data submitted successfully!')),
        );
      } else {
        throw Exception('Failed to save contract data: ${response.body}');
      }
    } catch (e) {
      log('Error saving contract data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving contract data: $e')),
      );
    }
  }

  // Validate the inputs
  bool _validateInputs() {
    if (contractDateController.text.isEmpty ||
        _signatureUrl == null ||
        saleAmountController.text.isEmpty ||
        selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contract Information'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text fields for contract data
              _buildTextField('Contract Date', contractDateController,
                  enabled: false),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => _captureSignature(context),
                    child: const Text('Capture Signature'),
                  ),
                ),
              ),
              _buildTextField('Sale Amount', saleAmountController),

              // Dropdown for payment method
              _buildPaymentMethodDropdown(),

              // Checkbox for ownership transfer
              _buildOwnershipTransferCheckbox(),

              _buildTextField('Additional Terms', additionalTermsController),
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
                    if (_validateInputs()) {
                      submitContractInfo();
                    }
                  },
                  child: const Text(
                    'Save Data',
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

  Widget _buildTextField(String label, TextEditingController controller,
      {bool enabled = true, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        controller: controller,
        enabled: enabled,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: DropdownButtonFormField<String>(
        value: selectedPaymentMethod,
        decoration: const InputDecoration(
          labelText: 'Payment Method',
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(),
        ),
        items: [
          'Cash',
          'Bank Transfer',
          'Credit Card',
          'Online Payment',
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
          const Expanded(child: Text('Legal ownership transfer commitment')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    contractDateController.dispose();
    saleAmountController.dispose();
    additionalTermsController.dispose();
    _signatureController.dispose();
    super.dispose();
  }
}
