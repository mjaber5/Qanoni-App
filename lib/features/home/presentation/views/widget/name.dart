
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class Name extends StatefulWidget {
  @override
  _IDScannerScreenState createState() => _IDScannerScreenState();
}

class _IDScannerScreenState extends State<Name> {
  final ImagePicker _picker = ImagePicker();
  XFile? _frontImageFile;
  XFile? _backImageFile;

  // Text Controllers for extracted name and address
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Initialize the text recognizer
  final TextRecognizer _textRecognizer = TextRecognizer();

  // Process the image with Google ML Kit
  Future<void> processImage(File imageFile, {required bool isFront}) async {
    final inputImage = InputImage.fromFile(imageFile);

    try {
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
      print('Recognized Text: ${recognizedText.text}');

      if (isFront) {
        extractNameData(recognizedText.text);
      } else {
        extractAddressData(recognizedText.text);
      }
    } catch (e) {
      print('Error processing image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to process image')),
      );
    }
  }

  // Extract name from the recognized text
void extractNameData(String recognizedText) {
  // Regex to match names (both Arabic and English names)
  final nameRegex = RegExp(r'[A-Z][A-Z\s]+|(?:\s+)+');
  final match = nameRegex.firstMatch(recognizedText);

  if (match != null) {
    final extractedName = match.group(0)!.trim();
    nameController.text = extractedName;
    print('Extracted Name: $extractedName'); // Print the name to the debug console
  } else {
    nameController.text = 'Name not found';
    print('Name not found'); // Print a message to the debug console if no name is found
  }
}

  // Extract address from the recognized text
  void extractAddressData(String recognizedText) {
    // Regex to match addresses (you may need to adjust this based on the format of the address)
    final addressRegex = RegExp(r'[A-Za-z0-9\s,.-]+');
    final match = addressRegex.firstMatch(recognizedText);

    if (match != null) {
      addressController.text = match.group(0)!.trim();
    } else {
      addressController.text = 'Address not found';
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
        title: const Text('ID Scanner (Name & Address)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                _frontImageFile != null
                    ? Image.file(File(_frontImageFile!.path), width: 150)
                    : const Text('Front Side Not Captured'),
                ElevatedButton(
                  onPressed: () => pickImage(isFront: true),
                  child: const Text('Capture Front'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                _backImageFile != null
                    ? Image.file(File(_backImageFile!.path), width: 150)
                    : const Text('Back Side Not Captured'),
                ElevatedButton(
                  onPressed: () => pickImage(isFront: false),
                  child: const Text('Capture Back'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller:nameController  ,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the text controllers to avoid memory leaks
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
