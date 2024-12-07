import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Add a contract to the Firestore `contracts` collection.
  Future<void> addContract({
    required String sellerId,
    required String buyerId,
    required String email,
    required String userName,
    required String phone,
    required String idNumber,
  }) async {
    try {
      // Prepare the contract data
      final contractData = {
        'sellerId': sellerId,
        'buyerId': buyerId,
        'status': 'pending', // Initial status
        'email': email,
        'userName': userName,
        'phone': phone,
        'idNumber': idNumber,
        'timestamp':
            FieldValue.serverTimestamp(), // Automatically set the timestamp
      };

      // Add the contract to the `contracts` collection
      final DocumentReference contractRef =
          await _firestore.collection('contracts').add(contractData);

      log("Contract added successfully with ID: ${contractRef.id}");
    } catch (e) {
      log("Error adding contract: $e");
    }
  }

  /// Fetch all contracts from Firestore for a given user.
  Future<List<Map<String, dynamic>>> fetchContracts(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('contracts')
          .where('buyerId', isEqualTo: userId) // Filter by buyerId
          .get();

      // Convert to a list of contract data
      return querySnapshot.docs
          .map((doc) =>
              {'contractId': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      log("Error fetching contracts: $e");
      return [];
    }
  }

  /// Update the status of a contract by ID.
  Future<void> updateContractStatus({
    required String contractId,
    required String newStatus, // 'approved' or 'rejected'
  }) async {
    try {
      await _firestore.collection('contracts').doc(contractId).update({
        'status': newStatus,
      });
      log("Contract $contractId updated to $newStatus");
    } catch (e) {
      log("Error updating contract status: $e");
    }
  }
}
