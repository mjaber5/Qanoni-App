import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/features/home/presentation/views/widget_form_input/buyer_contract.dart';
import 'package:qanoni/features/home/presentation/views/widget_form_input/seller_cuntract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';

class RequestScreen extends StatefulWidget {
  final String contractId;
  final String messageTitle;
  final String messageBody;
  final String userType; // 'buyer' or 'seller'

  const RequestScreen({
    super.key,
    required this.contractId,
    required this.messageTitle,
    required this.messageBody,
    required this.userType,
  });

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  bool isLoading = true;
  bool isVisible = true; // Track if the widget should be visible

  @override
  void initState() {
    super.initState();

    // Simulate a loading delay of 2-3 seconds
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void countinueContract() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => widget.userType == 'buyer'
            ? const SellerContract()
            : const BuyerContract(),
      ),
    );
  }

  Future<void> rejectContract() async {
    if (widget.contractId.isEmpty) {
      log('Error: contractId is empty.');
      return;
    }

    try {
      // Delete the document from Firestore
      await FirebaseFirestore.instance
          .collection('contracts')
          .doc(widget.contractId)
          .delete();

      setState(() {
        isVisible = false; // Hide the widget
      });

      log('Contract rejected and document deleted successfully.');
    } catch (e) {
      log('Error rejecting contract: $e');
    }
  }

  Widget buildShimmer() {
    return Shimmer.fromColors(
      baseColor: QColors.black.withOpacity(0.5),
      highlightColor: QColors.darkerGrey.withOpacity(0.5),
      child: Column(
        children: List.generate(
          1,
          (index) => Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.5),
            ),
            height: 150,
            width: double.infinity,
          ),
        ),
      ),
    );
  }

  Widget buildCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [
            QColors.black.withOpacity(0.1),
            QColors.black.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.messageTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.blueGrey,
            thickness: 1.5,
            height: 20,
          ),
          Text(
            widget.messageBody,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: countinueContract,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  backgroundColor: QColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.check, size: 20),
                label: const Text(
                  'Approve',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              ElevatedButton.icon(
                onPressed: rejectContract,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.cancel, size: 20),
                label: const Text(
                  'Reject',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                isLoading ? buildShimmer() : buildCard(),
              ],
            ),
          )
        : const SizedBox.shrink(); // Return an empty widget if not visible
  }
}
