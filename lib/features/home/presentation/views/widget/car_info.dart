import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class CarContract extends StatefulWidget {
  const CarContract({super.key});

  @override
  State<CarContract> createState() => _CarContractState();
}

class _CarContractState extends State<CarContract> {
  final ImagePicker _picker = ImagePicker();
  XFile? _frontImageFile;
  XFile? _backImageFile;

  // Text Controllers for extracted data
  final TextEditingController carPlateNumberController = TextEditingController();
  final TextEditingController vinNumberController = TextEditingController();
  final TextEditingController engineNumberController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carColorController = TextEditingController();
  final TextEditingController carRegistrationNumberController = TextEditingController();
  final TextEditingController insuranceExpiryDateController = TextEditingController();
  final TextEditingController carConditionController = TextEditingController();

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
    final registrationNumberMatch = registrationNumberRegex.firstMatch(recognizedText);
    if (registrationNumberMatch != null) {
      setState(() {
        carRegistrationNumberController.text = registrationNumberMatch.group(0)!;
      });
    }

    final insuranceExpiryDateRegex = RegExp(r'\b\d{2}/\d{2}/\d{4}\b');
    final insuranceExpiryDateMatch = insuranceExpiryDateRegex.firstMatch(recognizedText);
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
        title: const Text('Car Information Scanner'),
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
              _buildTextField('Car Plate Number', carPlateNumberController),
              _buildTextField('VIN Number', vinNumberController),
              _buildTextField('Engine Number', engineNumberController),
              _buildTextField('Car Model', carModelController),
              _buildTextField('Car Color', carColorController),
              _buildTextField('Car Registration Number', carRegistrationNumberController),
              _buildTextField('Insurance Expiry Date', insuranceExpiryDateController),
              _buildTextField('Car Condition', carConditionController),
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
