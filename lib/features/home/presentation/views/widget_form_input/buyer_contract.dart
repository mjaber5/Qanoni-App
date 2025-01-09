import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:qanoni/core/services/base.dart';
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // أضف هذا السطر


import 'package:qanoni/core/utils/constants/colors.dart';

class BuyerContract extends StatefulWidget {
  const BuyerContract({super.key});

  @override
  State<BuyerContract> createState() => _BuyerContractState();
}

class _BuyerContractState extends State<BuyerContract> {
  final ImagePicker _picker = ImagePicker();
  XFile? _frontImageFile;
  XFile? _backImageFile;

  // Text Controllers for extracted data
  final TextEditingController buyerFullNameController = TextEditingController();
  final TextEditingController buyerBirthDateController =
      TextEditingController();
  final TextEditingController buyerNationalIDController =
      TextEditingController();
  final TextEditingController buyerRegistryNumberController =
      TextEditingController();
  final TextEditingController buyerRegistryPlaceController =
      TextEditingController();
  final TextEditingController buyerExpiryDateController =
      TextEditingController();

  // Backend Base URL
  final String baseUrl = ConfigApi.baseUri;

  // Contract ID (to be fetched/updated during stage processing)
  String? contractId;

  // Process the image with ML Kit Text Recognition
  Future<void> processImage(File imageFile, {bool isFront = true}) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      if (isFront) {
        extractFrontData(recognizedText.text);
      } else {
        extractBackData(recognizedText.text);
      }
    } catch (e) {
      log('Error processing image: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to process image')),
      );
    } finally {
      textRecognizer.close();
    }
  }

  // Extract data from the front side (Buyer's details)
  void extractFrontData(String recognizedText) {
    final fullNameRegex = RegExp(r'([ء-ي]+(?:\s[ء-ي]+){1,3})');
    final fullNameMatch = fullNameRegex.firstMatch(recognizedText);
    if (fullNameMatch != null) {
      setState(() {
        buyerFullNameController.text = fullNameMatch.group(0)!.trim();
      });
    }

    final birthDateRegex = RegExp(r'\b\d{2}/\d{2}/\d{4}\b');
    final birthDateMatch = birthDateRegex.firstMatch(recognizedText);
    if (birthDateMatch != null) {
      setState(() {
        buyerBirthDateController.text = birthDateMatch.group(0)!;
      });
    }

    final nationalIDRegex = RegExp(r'\b\d{10}\b');
    final nationalIDMatch = nationalIDRegex.firstMatch(recognizedText);
    if (nationalIDMatch != null) {
      setState(() {
        buyerNationalIDController.text = nationalIDMatch.group(0)!;
      });
    }
  }

  // Extract data from the back side (Buyer's registry information)
  void extractBackData(String recognizedText) {
    final registryNumberRegex = RegExp(r'\b\d{1,5}/\d{1,5}\b');
    final registryNumberMatch = registryNumberRegex.firstMatch(recognizedText);
    if (registryNumberMatch != null) {
      setState(() {
        buyerRegistryNumberController.text = registryNumberMatch.group(0)!;
      });
    }

    final registryPlaceRegex = RegExp(r'مكان القيد[:\s]*([\u0621-\u064A\s]+)');
    final registryPlaceMatch = registryPlaceRegex.firstMatch(recognizedText);
    if (registryPlaceMatch != null) {
      setState(() {
        buyerRegistryPlaceController.text = registryPlaceMatch.group(1)!.trim();
      });
    }

    final expiryDateRegex = RegExp(r'\b\d{2}/\d{2}/\d{4}\b');
    final expiryDateMatch = expiryDateRegex.firstMatch(recognizedText);
    if (expiryDateMatch != null) {
      setState(() {
        buyerExpiryDateController.text = expiryDateMatch.group(0)!;
      });
    }
  }

  // Pick image from camera
  Future<void> pickImage({required bool isFront}) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          _frontImageFile = pickedFile;
        } else {
          _backImageFile = pickedFile;
        }
      });

      // Process the selected image
      processImage(File(pickedFile.path), isFront: isFront);
    }
  }

  Future<void> initializeContractId(String sellerIduse) async {
    if (contractId == null || contractId!.isEmpty) {
      try {
        log('Fetching contract ID for sellerIduse: $sellerIduse...');
        final response = await http.post(
          Uri.parse('$baseUrl/get-contract-id'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'sellerIduse': sellerIduse}),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseData = jsonDecode(response.body);
          contractId = responseData['contractId'];
          log('Fetched contract ID: $contractId');
        } else {
          throw Exception('Failed to fetch contract ID: ${response.body}');
        }
      } catch (e) {
        log('Error fetching contract ID: $e');
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching contract ID: $e')),
        );
      }
    }
  }

  // Submit the buyer's data to the backend
  Future<void> submitBuyerData(String buyerIduse) async {
    if (contractId == null || contractId!.isEmpty) {
      log('Error: contractId is missing. Cannot submit buyer data.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Contract ID is required.')),
      );
      return;
    }

    final buyerData = {
      'fullName': buyerFullNameController.text,
      'birthDate': buyerBirthDateController.text,
      'nationalID': buyerNationalIDController.text,
      'registryNumber': buyerRegistryNumberController.text,
      'registryPlace': buyerRegistryPlaceController.text,
      'expiryDate': buyerExpiryDateController.text,
    };

    final data = {
      'stage': 'buyer',
      'buyerData': buyerData,
      'buyerIduse': buyerIduse,
      'contractId': contractId,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/save-data'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        log('Response data: $responseData');
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Buyer data submitted successfully!')),
        );
      } else {
        throw Exception('Failed to save data: ${response.body}');
      }
    } catch (e) {
      log('Error saving buyer data: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving buyer data: $e')),
      );
    }
  }

  // Validate and submit the form
  void validateAndSubmit() async {
    if (buyerFullNameController.text.isEmpty ||
        buyerBirthDateController.text.isEmpty ||
        buyerNationalIDController.text.isEmpty ||
        buyerRegistryNumberController.text.isEmpty ||
        buyerRegistryPlaceController.text.isEmpty ||
        buyerExpiryDateController.text.isEmpty) {
      _showValidationDialog();
      return;
    }

    if (contractId == null || contractId!.isEmpty) {
      await initializeContractId('sellerIduse');
      if (!mounted) return;
    }

    if (contractId != null && contractId!.isNotEmpty) {
      submitBuyerData('buyerIduse');
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to initialize contract ID.')),
      );
    }
  }

  // Show validation error dialog
  void _showValidationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Validation Error'),
        content: const Text('Please fill in all required fields.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
        final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.buyerInformationScanner),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildImageSection(
                        imageFile: _frontImageFile,
                        label: localizations.frontSide,
                        isFront: true,
                      ),
                      _buildImageSection(
                        imageFile: _backImageFile,
                        label:  localizations.backSide,
                        isFront: false,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(localizations.buyerFullName, buyerFullNameController),
              _buildTextField(localizations.buyerBirthDate, buyerBirthDateController),
              _buildTextField(localizations.buyerNationalId, buyerNationalIDController),
              _buildTextField(localizations.buyerRegistryNumber, buyerRegistryNumberController),
              _buildTextField(localizations.buyerRegistryPlace, buyerRegistryPlaceController),
              _buildTextField(localizations.buyerExpiryDate, buyerExpiryDateController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: validateAndSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: QColors.secondary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(localizations.submit),
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
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildImageSection({
    XFile? imageFile,
    required String label,
    required bool isFront,
  }) {
    return Column(
      children: [
        imageFile != null
            ? Image.file(File(imageFile.path),
                width: 150, height: 200, fit: BoxFit.cover)
            : Text(label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        IconButton(
          onPressed: () => pickImage(isFront: isFront),
          icon:
              const Icon(Icons.camera_alt, color: QColors.secondary, size: 40),
        ),
      ],
    );
  }

  @override
  void dispose() {
    buyerFullNameController.dispose();
    buyerBirthDateController.dispose();
    buyerNationalIDController.dispose();
    buyerRegistryNumberController.dispose();
    buyerRegistryPlaceController.dispose();
    buyerExpiryDateController.dispose();
    super.dispose();
  }
}
