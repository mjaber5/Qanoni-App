import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // أضف هذا السطر


class SellerContract extends StatefulWidget {
  const SellerContract({super.key});

  @override
  State<SellerContract> createState() => _SellerContractState();
}

class _SellerContractState extends State<SellerContract> {
  final ImagePicker _picker = ImagePicker();
  XFile? _frontImageFile;
  XFile? _backImageFile;

  // Text Controllers for extracted data
  final TextEditingController sellerFullNameController =
      TextEditingController();
  final TextEditingController sellerBirthDateController =
      TextEditingController();
  final TextEditingController sellerNationalIDController =
      TextEditingController();
  final TextEditingController sellerRegistryNumberController =
      TextEditingController();
  final TextEditingController sellerRegistryPlaceController =
      TextEditingController();
  final TextEditingController sellerExpiryDateController =
      TextEditingController();

  // Backend Base URL
  final String baseUrl =
      'http://localhost:8080'; // Replace with your backend URL

  // Contract ID
  String? contractId;

  // Process the image with ML Kit Text Recognition
  Future<void> processImage(File imageFile, {required bool isFront}) async {
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

  // Extract data from the front side (Seller's details)
  void extractFrontData(String recognizedText) {
    final fullNameRegex = RegExp(r'([ء-ي]+(?:\s[ء-ي]+){1,3})');
    final fullNameMatch = fullNameRegex.firstMatch(recognizedText);
    if (fullNameMatch != null) {
      setState(() {
        sellerFullNameController.text = fullNameMatch.group(0)!.trim();
      });
    }

    final birthDateRegex = RegExp(r'\b\d{2}/\d{2}/\d{4}\b');
    final birthDateMatch = birthDateRegex.firstMatch(recognizedText);
    if (birthDateMatch != null) {
      setState(() {
        sellerBirthDateController.text = birthDateMatch.group(0)!;
      });
    }

    final nationalIDRegex = RegExp(r'\b\d{10}\b');
    final nationalIDMatch = nationalIDRegex.firstMatch(recognizedText);
    if (nationalIDMatch != null) {
      setState(() {
        sellerNationalIDController.text = nationalIDMatch.group(0)!;
      });
    }
  }

  // Extract data from the back side (Seller's registry information)
  void extractBackData(String recognizedText) {
    final registryNumberRegex = RegExp(r'\b\d{1,5}/\d{1,5}\b');
    final registryNumberMatch = registryNumberRegex.firstMatch(recognizedText);
    if (registryNumberMatch != null) {
      setState(() {
        sellerRegistryNumberController.text = registryNumberMatch.group(0)!;
      });
    }

    final registryPlaceRegex = RegExp(r'مكان القيد[:\s]*([\u0621-\u064A\s]+)');
    final registryPlaceMatch = registryPlaceRegex.firstMatch(recognizedText);
    if (registryPlaceMatch != null) {
      setState(() {
        sellerRegistryPlaceController.text =
            registryPlaceMatch.group(1)!.trim();
      });
    }

    final expiryDateRegex = RegExp(r'\b\d{2}/\d{2}/\d{4}\b');
    final expiryDateMatch = expiryDateRegex.firstMatch(recognizedText);
    if (expiryDateMatch != null) {
      setState(() {
        sellerExpiryDateController.text = expiryDateMatch.group(0)!;
      });
    }
  }

  // Submit the seller's data to the backend
  Future<void> submitSellerData() async {
    final sellerData = {
      'fullName': sellerFullNameController.text,
      'birthDate': sellerBirthDateController.text,
      'nationalID': sellerNationalIDController.text,
      'registryNumber': sellerRegistryNumberController.text,
      'registryPlace': sellerRegistryPlaceController.text,
      'expiryDate': sellerExpiryDateController.text,
    };

    final data = {
      'stage': 'seller',
      'sellerData': sellerData,
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
          const SnackBar(content: Text('Seller data submitted successfully!')),
        );
      } else {
        throw Exception('Failed to save seller data: ${response.body}');
      }
    } catch (e) {
      log('Error saving seller data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving seller data: $e')),
      );
    }
  }

  // Validate and submit the form
  void validateAndSubmit() {
    if (sellerFullNameController.text.isEmpty ||
        sellerBirthDateController.text.isEmpty ||
        sellerNationalIDController.text.isEmpty ||
        sellerRegistryNumberController.text.isEmpty ||
        sellerRegistryPlaceController.text.isEmpty ||
        sellerExpiryDateController.text.isEmpty) {
      _showValidationDialog();
    } else {
      submitSellerData();
    }
  }

  // Show validation error dialog
  void _showValidationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:  Text(AppLocalizations.of(context)!.validationError),
        content:  Text(AppLocalizations.of(context)!.pleaseFillInAllFields
),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child:  Text(
              AppLocalizations.of(context)!.ok
,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // Method to pick an image
  Future<void> pickImage({required bool isFront}) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          if (isFront) {
            _frontImageFile = pickedFile;
          } else {
            _backImageFile = pickedFile;
          }
        });
        processImage(File(pickedFile.path), isFront: isFront);
      }
    } catch (e) {
      log('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(AppLocalizations.of(context)!.failedToPickImage
)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.sellerInformationScanner
),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Front and Back Image Picker Section
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildImageSection(
                        imageFile: _frontImageFile,
                        label: AppLocalizations.of(context)!.frontSide,
                        isFront: true,
                      ),
                      _buildImageSection(
                        imageFile: _backImageFile,
                        label: AppLocalizations.of(context)!.backSide,
                        isFront: false,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(AppLocalizations.of(context)!.sellerFullName, sellerFullNameController),
              _buildTextField(AppLocalizations.of(context)!.sellerBirthDate, sellerBirthDateController),
              _buildTextField(AppLocalizations.of(context)!.sellerNationalID, sellerNationalIDController),
              _buildTextField(
                  AppLocalizations.of(context)!.sellerRegistryNumber, sellerRegistryNumberController),
              _buildTextField(
                  AppLocalizations.of(context)!.sellerRegistryPlace, sellerRegistryPlaceController),
              _buildTextField(AppLocalizations.of(context)!.sellerExpiryDate, sellerExpiryDateController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: validateAndSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child:  Text(AppLocalizations.of(context)!.submit),
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
          icon: const Icon(Icons.camera_alt, color: Colors.blue, size: 40),
        ),
      ],
    );
  }

  @override
  void dispose() {
    sellerFullNameController.dispose();
    sellerBirthDateController.dispose();
    sellerNationalIDController.dispose();
    sellerRegistryNumberController.dispose();
    sellerRegistryPlaceController.dispose();
    sellerExpiryDateController.dispose();
    super.dispose();
  }
}
