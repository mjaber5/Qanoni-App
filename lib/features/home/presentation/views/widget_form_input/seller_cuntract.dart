import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qanoni/core/services/base.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

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
  final String baseUrl = ConfigApi.baseUri; // Replace with your backend URL

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
    final sellerIduse = FirebaseAuth.instance.currentUser?.uid;
    if (sellerIduse == null) {
      log('Error: User is not authenticated.');
      return;
    }

    final sellerData = {
      'sellerIduse': sellerIduse,
      'fullName': sellerFullNameController.text.trim(),
      'birthDate': sellerBirthDateController.text.trim(),
      'nationalID': sellerNationalIDController.text.trim(),
      'registryNumber': sellerRegistryNumberController.text.trim(),
      'registryPlace': sellerRegistryPlaceController.text.trim(),
      'expiryDate': sellerExpiryDateController.text.trim(),
    };

    try {
      // Fetch or create contract ID
      final contractIdResponse = await http.post(
        Uri.parse('$baseUrl/get-contract-id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'sellerIduse': sellerIduse}),
      );

      if (contractIdResponse.statusCode == 200 ||
          contractIdResponse.statusCode == 201) {
        final responseData = jsonDecode(contractIdResponse.body);
        contractId = responseData['contractId'];

        // Submit seller data
        final data = {
          'stage': 'seller',
          'sellerData': sellerData,
          'contractId': contractId,
        };

        final response = await http.post(
          Uri.parse('$baseUrl/save-data'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          log('Seller data submitted successfully: Contract ID = $contractId');
          GoRouter.of(context)
              .push(AppRouter.kCarInformation, extra: contractId);
        } else {
          throw Exception('Failed to save seller data.');
        }
      } else {
        throw Exception('Failed to fetch or create contract ID.');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

// Validate and submit the form
  void validateAndSubmit() {
    if (sellerFullNameController.text.isEmpty) {
      _showValidationDialog('Seller full name is required.');
      return;
    }
    if (sellerBirthDateController.text.isEmpty) {
      _showValidationDialog('Seller birth date is required.');
      return;
    }
    if (sellerNationalIDController.text.isEmpty) {
      _showValidationDialog('Seller national ID is required.');
      return;
    }
    if (sellerRegistryNumberController.text.isEmpty) {
      _showValidationDialog('Seller registry number is required.');
      return;
    }
    if (sellerRegistryPlaceController.text.isEmpty) {
      _showValidationDialog('Seller registry place is required.');
      return;
    }
    if (sellerExpiryDateController.text.isEmpty) {
      _showValidationDialog('Seller expiry date is required.');
      return;
    }

    // All fields are valid, proceed to submit data
    submitSellerData();
  }

// Show validation error dialog
  void _showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Validation Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Method to pick an image
  Future<void> pickImage({required bool isFront}) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
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
        SnackBar(
            content: Text(AppLocalizations.of(context)!.failedToPickImage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Information Scanner'),
        backgroundColor: QColors.secondary,
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
              _buildTextField(AppLocalizations.of(context)!.sellerFullName,
                  sellerFullNameController),
              _buildTextField(AppLocalizations.of(context)!.sellerBirthDate,
                  sellerBirthDateController),
              _buildTextField(AppLocalizations.of(context)!.sellerNationalID,
                  sellerNationalIDController),
              _buildTextField(
                  AppLocalizations.of(context)!.sellerRegistryNumber,
                  sellerRegistryNumberController),
              _buildTextField(AppLocalizations.of(context)!.sellerRegistryPlace,
                  sellerRegistryPlaceController),
              _buildTextField(AppLocalizations.of(context)!.sellerExpiryDate,
                  sellerExpiryDateController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  validateAndSubmit();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: QColors.secondary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(AppLocalizations.of(context)!.submit),
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
    sellerFullNameController.dispose();
    sellerBirthDateController.dispose();
    sellerNationalIDController.dispose();
    sellerRegistryNumberController.dispose();
    sellerRegistryPlaceController.dispose();
    sellerExpiryDateController.dispose();
    super.dispose();
  }
}
