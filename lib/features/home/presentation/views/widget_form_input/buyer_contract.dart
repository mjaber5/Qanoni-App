import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/features/home/data/contract_status/contract_status_cubit.dart';
import 'package:qanoni/features/home/presentation/views/widget_form_input/view_car_info.dart';

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
      // ignore: use_build_context_synchronously
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

  // Submit the buyer's contract and move it to Firebase
  void submitBuyerContract() {
    final buyerData = {
      'fullName': buyerFullNameController.text,
      'birthDate': buyerBirthDateController.text,
      'nationalID': buyerNationalIDController.text,
      'registryNumber': buyerRegistryNumberController.text,
      'registryPlace': buyerRegistryPlaceController.text,
      'expiryDate': buyerExpiryDateController.text,
    };

    final sellerData = {
      // You need to populate this with seller data, maybe passed from another screen or session
      'fullName': 'Seller Name',
      'nationalID': 'Seller National ID',
      'phone': 'Seller Phone',
    };

    // Call the ContractCubit to create the contract with both buyer and seller data
    context.read<ContractCubit>().createContract(
          otherUserId: 'sellerId', // Replace with actual seller ID
          userType: 'buyer', // Set the user type as needed
          buyerData: buyerData,
          sellerData: sellerData,
        );
  }

  // Validate and submit the form
  void validateAndSubmit() {
    if (buyerFullNameController.text.isEmpty ||
        buyerBirthDateController.text.isEmpty ||
        buyerNationalIDController.text.isEmpty ||
        buyerRegistryNumberController.text.isEmpty ||
        buyerRegistryPlaceController.text.isEmpty ||
        buyerExpiryDateController.text.isEmpty) {
      _showValidationDialog();
    } else {
      submitBuyerContract();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ViewCarInfo()),
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
            child: const Text('OK',style: TextStyle(color: QColors.secondary),),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyer Information Scanner'),
        backgroundColor: QColors.secondary, // Better color contrast
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
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
              _buildTextField('Buyer Full Name', buyerFullNameController),
              _buildTextField('Buyer Birth Date', buyerBirthDateController),
              _buildTextField('Buyer National ID', buyerNationalIDController),
              _buildTextField(
                  'Buyer Registry Number', buyerRegistryNumberController),
              _buildTextField(
                  'Buyer Registry Place', buyerRegistryPlaceController),
              _buildTextField('Buyer Expiry Date', buyerExpiryDateController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: validateAndSubmit, // Use the validation method
                style: ElevatedButton.styleFrom(
                  backgroundColor: QColors.secondary,
                  minimumSize: const Size(double.infinity, 50), // Full width button
                ),
                child: const Text('Next Step'),
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
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: QColors.secondary, width: 2.0),
          ),
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
}
