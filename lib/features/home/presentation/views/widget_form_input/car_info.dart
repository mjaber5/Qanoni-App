import 'dart:io';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:qanoni/core/services/base.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // أضف هذا السطر

import 'package:qanoni/core/utils/constants/colors.dart';

class CarInfo extends StatefulWidget {
  const CarInfo({super.key});

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  XFile? _frontImageFile;
  XFile? _backImageFile;

  // Text Controllers for extracted data
  final TextEditingController carPlateNumberController =
      TextEditingController();
  final TextEditingController vinNumberController = TextEditingController();
  final TextEditingController engineNumberController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carColorController = TextEditingController();
  final TextEditingController carRegistrationNumberController =
      TextEditingController();
  final TextEditingController insuranceExpiryDateController =
      TextEditingController();
  final TextEditingController carConditionController = TextEditingController();

  // Backend Base URL
  final String baseUrl = ConfigApi.baseUri; // Replace with your backend URL

  // Contract ID (to be updated during the stage process)
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

  // Extract data from the front side (Car details)
  void extractFrontData(String recognizedText) {
    final plateNumberRegex = RegExp(r'\b[A-Za-z0-9]{2,10}\b');
    final plateNumberMatch = plateNumberRegex.firstMatch(recognizedText);
    if (plateNumberMatch != null) {
      setState(() {
        carPlateNumberController.text = plateNumberMatch.group(0)!;
      });
    }

    final vinNumberRegex = RegExp(r'\b[0-9A-HJ-NPR-Z]{17}\b');
    final vinNumberMatch = vinNumberRegex.firstMatch(recognizedText);
    if (vinNumberMatch != null) {
      setState(() {
        vinNumberController.text = vinNumberMatch.group(0)!;
      });
    }

    final engineNumberRegex = RegExp(r'\b[A-Za-z0-9]{6,20}\b');
    final engineNumberMatch = engineNumberRegex.firstMatch(recognizedText);
    if (engineNumberMatch != null) {
      setState(() {
        engineNumberController.text = engineNumberMatch.group(0)!;
      });
    }

    final carModelRegex = RegExp(r'([A-Za-z]+(?:\s[A-Za-z]+){1,2})');
    final carModelMatch = carModelRegex.firstMatch(recognizedText);
    if (carModelMatch != null) {
      setState(() {
        carModelController.text = carModelMatch.group(0)!.trim();
      });
    }

    final carColorRegex = RegExp(r'([A-Za-z]+)');
    final carColorMatch = carColorRegex.firstMatch(recognizedText);
    if (carColorMatch != null) {
      setState(() {
        carColorController.text = carColorMatch.group(0)!.trim();
      });
    }
  }

  // Extract data from the back side (Car registration and condition)
  void extractBackData(String recognizedText) {
    final registrationNumberRegex = RegExp(r'\b\d{1,5}/\d{1,5}\b');
    final registrationNumberMatch =
        registrationNumberRegex.firstMatch(recognizedText);
    if (registrationNumberMatch != null) {
      setState(() {
        carRegistrationNumberController.text =
            registrationNumberMatch.group(0)!;
      });
    }

    final insuranceExpiryDateRegex = RegExp(r'\b\d{2}/\d{2}/\d{4}\b');
    final insuranceExpiryDateMatch =
        insuranceExpiryDateRegex.firstMatch(recognizedText);
    if (insuranceExpiryDateMatch != null) {
      setState(() {
        insuranceExpiryDateController.text = insuranceExpiryDateMatch.group(0)!;
      });
    }

    final carConditionRegex = RegExp(r'(جديدة|مستعملة)');
    final carConditionMatch = carConditionRegex.firstMatch(recognizedText);
    if (carConditionMatch != null) {
      setState(() {
        carConditionController.text = carConditionMatch.group(0)!;
      });
    }
  }

  // Submit the car's data to the backend
  Future<void> initializeContractId(String sellerIduse) async {
    if (contractId == null || contractId!.isEmpty) {
      try {
        log('Fetching or creating contract ID for sellerIduse: $sellerIduse...');
        final response = await http.post(
          Uri.parse('$baseUrl/get-contract-id'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'sellerIduse': sellerIduse}),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseData = jsonDecode(response.body);
          contractId = responseData['contractId'];
          log('Fetched or created contract ID: $contractId');
        } else {
          throw Exception(
              'Failed to fetch or create contract: ${response.body}');
        }
      } catch (e) {
        log('Error fetching or creating contract ID: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching or creating contract ID: $e')),
        );
      }
    }
  }

  Future<void> submitCarData() async {
    if (contractId == null) {
      log('Error: contractId is missing. Cannot submit car data.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Contract ID is missing.')),
      );
      return;
    }

    final carData = {
      'carPlateNumber': carPlateNumberController.text.trim(),
      'vinNumber': vinNumberController.text.trim(),
      'engineNumber': engineNumberController.text.trim(),
      'carModel': carModelController.text.trim(),
      'carColor': carColorController.text.trim(),
      'carRegistrationNumber': carRegistrationNumberController.text.trim(),
      'insuranceExpiryDate': insuranceExpiryDateController.text.trim(),
      'carCondition': carConditionController.text.trim(),
    };

    final data = {
      'stage': 'car',
      'carData': carData,
      'contractId': contractId, // Use contractId from the previous stage
    };

    try {
      log('Submitting car data: ${jsonEncode(data)}');
      final response = await http.post(
        Uri.parse('$baseUrl/save-data'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        log('Car data submitted successfully.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Car data submitted successfully!')),
        );
        // Navigate to the Contract Data form
        GoRouter.of(context)
            .push(AppRouter.kContractInformationForm, extra: contractId);
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception('Failed to save car data: ${errorResponse['error']}');
      }
    } catch (e) {
      log('Error saving car data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving car data: $e')),
      );
    }
  }

  void validateAndSubmit() async {
    if (carPlateNumberController.text.isEmpty ||
        vinNumberController.text.isEmpty ||
        engineNumberController.text.isEmpty ||
        carModelController.text.isEmpty ||
        carColorController.text.isEmpty ||
        carRegistrationNumberController.text.isEmpty ||
        insuranceExpiryDateController.text.isEmpty ||
        carConditionController.text.isEmpty) {
      _showValidationDialog();
      return;
    }

    await initializeContractId(_auth.currentUser!.uid);

    if (contractId != null) {
      await submitCarData();
    } else {
      log('Error: contractId is still null after initialization.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Error: Failed to initialize or retrieve contract ID.')),
      );
    }
  }

  // Show validation error dialog
  void _showValidationDialog() {
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.validation_error),
        content: Text(localizations.fill_all_fields),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              localizations.ok,
              style: const TextStyle(color: QColors.error),
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
        title: Text(localizations.car_info_title),
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
                        label: localizations.backSide,
                        isFront: false,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                  localizations.car_plate_number, carPlateNumberController),
              _buildTextField(localizations.vin_number, vinNumberController),
              _buildTextField(
                  localizations.engine_number, engineNumberController),
              _buildTextField(localizations.car_model, carModelController),
              _buildTextField(localizations.car_color, carColorController),
              _buildTextField(localizations.car_registration_number,
                  carRegistrationNumberController),
              _buildTextField(localizations.insurance_expiry_date,
                  insuranceExpiryDateController),
              _buildTextField(
                  localizations.car_condition, carConditionController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  validateAndSubmit();
                  // GoRouter.of(context).push(AppRouter.kContractInformationForm);
                },
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

  // Method to pick an image
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
      processImage(File(pickedFile.path), isFront: isFront);
    }
  }

  @override
  void dispose() {
    carPlateNumberController.dispose();
    vinNumberController.dispose();
    engineNumberController.dispose();
    carModelController.dispose();
    carColorController.dispose();
    carRegistrationNumberController.dispose();
    insuranceExpiryDateController.dispose();
    carConditionController.dispose();
    super.dispose();
  }
}
