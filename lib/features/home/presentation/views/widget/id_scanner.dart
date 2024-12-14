import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class IDScanner extends StatefulWidget {
  @override
  _IDScannerScreenState createState() => _IDScannerScreenState();
}

class _IDScannerScreenState extends State<IDScanner> {
  final ImagePicker _picker = ImagePicker();
  XFile? _frontImageFile;
  XFile? _backImageFile;

  // Text Controllers for extracted data
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController nationalIDController = TextEditingController();
  final TextEditingController registryNumberController = TextEditingController();
  final TextEditingController registryPlaceController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

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
      print('Error processing image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to process image')),
      );
    } finally {
      textRecognizer.close();
    }
  }

  // Extract data from the front side
  void extractFrontData(String recognizedText) {
    // Extract Full Name (Arabic names, assuming 4 words minimum)
    final fullNameRegex = RegExp(r'([ء-ي]+(?:\s[ء-ي]+){1,3})');
    final fullNameMatch = fullNameRegex.firstMatch(recognizedText);
    if (fullNameMatch != null) {
      setState(() {
        fullNameController.text = fullNameMatch.group(0)!.trim();
      });
    }

    // Extract Birth Date (Format: DD/MM/YYYY or similar)
    final birthDateRegex = RegExp(r'\b\d{2}/\d{2}/\d{4}\b');
    final birthDateMatch = birthDateRegex.firstMatch(recognizedText);
    if (birthDateMatch != null) {
      setState(() {
        birthDateController.text = birthDateMatch.group(0)!;
      });
    }

    // Extract National ID (Assuming it's a 10-digit number)
    final nationalIDRegex = RegExp(r'\b\d{10}\b');
    final nationalIDMatch = nationalIDRegex.firstMatch(recognizedText);
    if (nationalIDMatch != null) {
      setState(() {
        nationalIDController.text = nationalIDMatch.group(0)!;
      });
    }
  }

  // Extract data from the back side
  void extractBackData(String recognizedText) {
    // Extract Registry Number (Format: AAAAA/BBBB)
    final registryNumberRegex = RegExp(r'\b\d{1,5}/\d{1,5}\b');
    final registryNumberMatch = registryNumberRegex.firstMatch(recognizedText);
    if (registryNumberMatch != null) {
      setState(() {
        registryNumberController.text = registryNumberMatch.group(0)!;
      });
    }

    // Extract Registry Place (Arabic text, assuming keyword "مكان القيد")
    final registryPlaceRegex = RegExp(r'مكان القيد[:\s]*([\u0621-\u064A\s]+)');
    final registryPlaceMatch = registryPlaceRegex.firstMatch(recognizedText);
    if (registryPlaceMatch != null) {
      setState(() {
        registryPlaceController.text = registryPlaceMatch.group(1)!.trim();
      });
    }

    // Extract Expiry Date (Format: DD/MM/YYYY)
    final expiryDateRegex = RegExp(r'\b\d{2}/\d{2}/\d{4}\b');
    final expiryDateMatch = expiryDateRegex.firstMatch(recognizedText);
    if (expiryDateMatch != null) {
      setState(() {
        expiryDateController.text = expiryDateMatch.group(0)!;
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
        title: const Text('Jordanian ID Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              TextField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: birthDateController,
                decoration: const InputDecoration(
                  labelText: 'Birth Date',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nationalIDController,
                decoration: const InputDecoration(
                  labelText: 'National ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: registryNumberController,
                decoration: const InputDecoration(
                  labelText: 'Registry Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: registryPlaceController,
                decoration: const InputDecoration(
                  labelText: 'Registry Place',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: expiryDateController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the text controllers to avoid memory leaks
    fullNameController.dispose();
    birthDateController.dispose();
    nationalIDController.dispose();
    registryNumberController.dispose();
    registryPlaceController.dispose();
    expiryDateController.dispose();
    super.dispose();
  }
}
