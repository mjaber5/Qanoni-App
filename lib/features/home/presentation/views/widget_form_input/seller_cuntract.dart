import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

import 'car_info.dart';

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

  final _formKey = GlobalKey<FormState>(); // Form validation key

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
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to process image')));
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

      processImage(File(pickedFile.path), isFront: isFront);
    }
  }

  // Validate form and navigate to next screen
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CarInfo()),
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
          child: Form(
            key: _formKey,
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
                          label: 'Front Side',
                          isFront: true,
                        ),
                        _buildImageSection(
                          imageFile: _backImageFile,
                          label: 'Back Side',
                          isFront: false,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Text fields for extracted data
                _buildTextField('Seller Full Name', sellerFullNameController),
                _buildTextField('Seller Birth Date', sellerBirthDateController),
                _buildTextField(
                    'Seller National ID', sellerNationalIDController),
                _buildTextField(
                    'Seller Registry Number', sellerRegistryNumberController),
                _buildTextField(
                    'Seller Registry Place', sellerRegistryPlaceController),
                _buildTextField(
                    'Seller Expiry Date', sellerExpiryDateController),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: QColors.secondary,
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Next Step'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Image Section widget
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

  // Reusable TextField widget
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: QColors.secondary, width: 2.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
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
