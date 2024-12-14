import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class BuyerCuntract extends StatefulWidget {
  const BuyerCuntract({super.key});

  @override
  State<BuyerCuntract> createState() => _BuyerContractState();
}

class _BuyerContractState extends State<BuyerCuntract> {
  final ImagePicker _picker = ImagePicker();
  XFile? _frontImageFile;
  XFile? _backImageFile;

  // Text Controllers for extracted data
  final TextEditingController buyerFullNameController = TextEditingController();
  final TextEditingController buyerBirthDateController = TextEditingController();
  final TextEditingController buyerNationalIDController = TextEditingController();
  final TextEditingController buyerRegistryNumberController = TextEditingController();
  final TextEditingController buyerRegistryPlaceController = TextEditingController();
  final TextEditingController buyerExpiryDateController = TextEditingController();

  // Process the image with ML Kit Text Recognition
  Future<void> processImage(File imageFile, {bool isFront = true}) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();

    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

      if (isFront) {
        extractFrontData(recognizedText.text);
      } else {
        extractBackData(recognizedText.text);
      }
    } catch (e) {
      print('Error processing image: $e');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyer Information Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Front and Back Image Picker Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _frontImageFile != null
                          ? Image.file(File(_frontImageFile!.path), width: 150)
                          : const Text('Front Side'),
                      ElevatedButton(
                        onPressed: () => pickImage(isFront: true),
                        child: const Text('Capture Front'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      _backImageFile != null
                          ? Image.file(File(_backImageFile!.path), width: 150)
                          : const Text('Back Side'),
                      ElevatedButton(
                        onPressed: () => pickImage(isFront: false),
                        child: const Text('Capture Back'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Text fields for extracted data
              _buildTextField('Buyer Full Name', buyerFullNameController),
              _buildTextField('Buyer Birth Date', buyerBirthDateController),
              _buildTextField('Buyer National ID', buyerNationalIDController),
              _buildTextField('Buyer Registry Number', buyerRegistryNumberController),
              _buildTextField('Buyer Registry Place', buyerRegistryPlaceController),
              _buildTextField('Buyer Expiry Date', buyerExpiryDateController),
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
    buyerFullNameController.dispose();
    buyerBirthDateController.dispose();
    buyerNationalIDController.dispose();
    buyerRegistryNumberController.dispose();
    buyerRegistryPlaceController.dispose();
    buyerExpiryDateController.dispose();
    super.dispose();
  }
}
