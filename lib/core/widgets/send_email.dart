import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:qanoni/core/services/base.dart';

class SendEmailButton extends StatefulWidget {
  const SendEmailButton({super.key});

  @override
  State<SendEmailButton> createState() => _SendEmailButtonState();
}

class _SendEmailButtonState extends State<SendEmailButton> {
  String? contractId;
  bool isLoading = false;
  String baseUri = ConfigApi.baseUri;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fetch or create contract ID from the backend
  Future<void> _fetchOrCreateContractId(String sellerIduse) async {
    if (contractId == null || contractId!.isEmpty) {
      try {
        log('Fetching or creating contract ID for sellerIduse: $sellerIduse...');
        final response = await http.post(
          Uri.parse('$baseUri/get-contract-id'),
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

  Future<void> _initializeContractId() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        String sellerIduse = user.uid; // Assume sellerIduse is same as user.uid
        await _fetchOrCreateContractId(
            sellerIduse); // Fetch contractId using sellerIduse
      } else {
        log("User is not logged in.");
      }
    } catch (e) {
      log("Error fetching contractId: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching contract ID: $e')),
      );
    }
  }

  Future<void> sendEmail() async {
    if (contractId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contract ID not available')),
      );
      return;
    }

    String baseUri = ConfigApi.baseUri;
    final String apiUrl =
        '$baseUri/send-email'; // Backend endpoint to send email

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'contractId': contractId}),
      );

      if (response.statusCode == 200) {
        debugPrint('Emails sent successfully.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Emails sent successfully!')),
        );
      } else {
        debugPrint('Failed to send emails: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send emails: ${response.body}')),
        );
      }
    } catch (e) {
      debugPrint('Error sending emails: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error sending emails.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeContractId(); // Automatically fetch the contract ID when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Contract Email'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green.shade600,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                  vertical: screenHeight * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: screenHeight * 0.1,
                      color: Colors.green,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Send Contract Email',
                      style: TextStyle(
                        fontSize: screenHeight * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      'Click the button below to send the contract details via email.',
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    ElevatedButton.icon(
                      onPressed: sendEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                          horizontal: screenWidth * 0.1,
                        ),
                        elevation: 5,
                      ),
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Send Email',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
