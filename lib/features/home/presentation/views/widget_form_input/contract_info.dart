import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qanoni/core/services/base.dart';
import 'package:qanoni/features/home/data/contract_repo.dart';
import 'package:qanoni/features/home/data/model/contract_information_data.dart';
import 'package:signature/signature.dart';
import '../../../../../core/utils/constants/colors.dart';

class ContractInfoForm extends StatefulWidget {
  const ContractInfoForm({super.key});

  @override
  State<ContractInfoForm> createState() => _ContractInfoFormState();
}

class _ContractInfoFormState extends State<ContractInfoForm> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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

  String? _signatureUrl;

  // Backend repository instance
  final ContractRepo contractRepo = ContractRepo(baseUrl: ConfigApi.baseUri);

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
                  // Save signature locally or upload to Firebase
                  setState(() {
                    _signatureUrl =
                        'User Signature Captured'; // Placeholder for signature URL
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

  // Method to submit contract info
  Future<void> submitContractInfo() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in.')),
        );
        return;
      }

      final contractInfo = ContractInfo(
        contractDate: contractDateController.text,
        contractPlace: _signatureUrl ?? 'No Signature',
        saleAmount: saleAmountController.text,
        paymentMethod: selectedPaymentMethod ?? 'online',
        ownershipTransfer: ownershipTransferChecked,
        additionalTerms: additionalTermsController.text,
      );

      await contractRepo.createContract(
        buyerIduse: currentUser.uid,
        sellerIduse: 'seller123', // Replace with actual seller ID
        contractDetails: {
          'contractInfo': contractInfo.toMap(),
        },
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contract data saved successfully!')),
      );
    } catch (e) {
      log('Error saving contract data: $e');
      if (!mounted) return;
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all required fields.')),
        );
      });
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
        backgroundColor: QColors.secondary,
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
          labelText: 'Payment Method',
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: QColors.secondary),
          ),
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
    // Dispose the text controllers and signature controller to avoid memory leaks
    contractDateController.dispose();
    saleAmountController.dispose();
    additionalTermsController.dispose();
    _signatureController.dispose();
    super.dispose();
  }
}
