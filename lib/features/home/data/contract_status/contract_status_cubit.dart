import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'contract_status_state.dart';

class ContractCubit extends Cubit<ContractStatusState> {
  ContractCubit() : super(ContractStatusInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String enteredUserId = ''; // For tracking the entered user ID
  String contractId = ''; // For storing the contract ID after creation

  /// Create a new contract and set its initial status to "pending"
  Future<void> createContract({
    required String otherUserId,
    required String userType,
    required Map<String, dynamic> buyerData,
    required Map<String, dynamic> sellerData,
    Map<String, dynamic>? currentUser,
  }) async {
    emit(ContractLoading());
    try {
      final User? currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        emit(const ContractError('User not logged in.'));
        return;
      }

      final currentUserDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();
      if (!currentUserDoc.exists) {
        emit(const ContractError('User data not found.'));
        return;
      }

      final currentUserData = currentUserDoc.data();
      if (currentUserData == null) {
        emit(const ContractError('Invalid user data.'));
        return;
      }

      // Create contract data
      final contractData = {
        'sellerId': currentUser.uid,
        'buyerId': otherUserId,
        'status': 'pending', // Initial status
        'buyerData': buyerData, // Passing buyer data
        'sellerData': sellerData, // Passing seller data
        'email': currentUserData['email'],
        'userName': currentUserData['userName'],
        'phone': currentUserData['phone'],
        'idNumber': currentUserData['idNumber'],
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Add the contract to Firestore and get the contract ID
      final contractRef =
          await _firestore.collection('contracts').add(contractData);
      contractId = contractRef.id; // Store the contract ID after creation

      emit(ContractSuccess(
          'Contract request sent successfully! Contract ID: $contractId'));
    } catch (e) {
      emit(ContractError('Failed to create contract: ${e.toString()}'));
    }
  }

  /// Change the contract's status to "in-progress" when an agent views it
  Future<void> setInProgress({required String contractId}) async {
    emit(ContractLoading());
    try {
      await _firestore.collection('contracts').doc(contractId).update({
        'status': 'in-progress',
      });
      emit(const ContractUpdated('in-progress'));
    } catch (e) {
      emit(ContractError(
          'Failed to update status to in-progress: ${e.toString()}'));
    }
  }

  /// Respond to the contract: Approve or Reject
  Future<void> respondToContract({
    required String contractId,
    required String response, // Accepts "approved" or "rejected"
  }) async {
    emit(ContractLoading());
    try {
      await _firestore.collection('contracts').doc(contractId).update({
        'status': response,
      });
      emit(ContractUpdated(response));
    } catch (e) {
      emit(ContractError('Failed to respond to contract: ${e.toString()}'));
    }
  }

  /// Fetch contracts with the given status for a specific user
  Future<List<Map<String, dynamic>>> fetchContractsForUser({
    required String userId,
    String? status, // Optional status filter
  }) async {
    try {
      Query query = _firestore
          .collection('contracts')
          .where('buyerId', isEqualTo: userId);
      if (status != null) {
        query = query.where('status', isEqualTo: status);
      }

      final querySnapshot = await query.get();

      return querySnapshot.docs.map((doc) {
        return {
          'contractId': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    } catch (e) {
      emit(ContractError('Failed to fetch contracts: ${e.toString()}'));
      return [];
    }
  }

  /// Set the entered user ID
  void setUserId(String userId) {
    enteredUserId = userId;
    emit(ContractUserIdUpdated(userId));
  }

  /// Get both sellerId and buyerId from the contract data
  Future<Map<String, String>> getBuyerAndSellerIds() async {
    try {
      // Fetch contract document by contractId
      final contractDoc =
          await _firestore.collection('contracts').doc(contractId).get();
      if (contractDoc.exists) {
        final contractData = contractDoc.data() as Map<String, dynamic>;
        // Return both buyerId and sellerId in a map
        return {
          'sellerId': contractData['sellerId'] ?? '',
          'buyerId': contractData['buyerId'] ?? '',
        };
      } else {
        emit(const ContractError('Contract not found.'));
        return {'sellerId': '', 'buyerId': ''};
      }
    } catch (e) {
      emit(ContractError(
          'Failed to fetch sellerId and buyerId: ${e.toString()}'));
      return {'sellerId': '', 'buyerId': ''};
    }
  }

  /// Get the entered user ID
  String getEnteredUserId() {
    return enteredUserId;
  }

  /// Get the contract ID
  String getContractId() {
    return contractId;
  }
}
