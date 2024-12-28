import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qanoni/features/home/data/contract_repo.dart';
import 'package:qanoni/features/home/data/model/buyer_data.dart';
import 'package:qanoni/features/home/data/model/car_information_data.dart';
import 'package:qanoni/features/home/data/model/contract_information_data.dart';
import 'package:qanoni/features/home/data/model/seller_data.dart';

part 'contract_status_state.dart';

class ContractCubit extends Cubit<ContractStatusState> {
  ContractCubit(this._contractRepo) : super(ContractStatusInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ContractRepo _contractRepo;

  String contractId = ''; // For storing the contract ID after creation

  /// Create a new contract and set its initial status to "pending"
  Future<void> createContract({
    required String otherUserId,
    required String userType, // Could be "buyer" or "seller"
    required Buyer buyer,
    required Seller seller,
    required CarInfoForm carInfo,
    required ContractInfo contractInfo,
  }) async {
    emit(ContractLoading());
    try {
      final User? currentUser = _firebaseAuth.currentUser;

      // Ensure the current user is logged in
      if (currentUser == null) {
        emit(const ContractError('User not logged in.'));
        return;
      }

      // Ensure required parameters are valid
      if (otherUserId.isEmpty || userType.isEmpty) {
        emit(const ContractError('Invalid user type or other user ID.'));
        return;
      }

      // Save the contract data via ContractRepo
      final contractRef = await _contractRepo.saveContract(
        buyer: buyer,
        seller: seller,
        carInfo: carInfo,
        contractInfo: contractInfo,
        creatorId: currentUser.uid,
        otherUserId: otherUserId,
        userType: userType,
      );

      // Log the contract ID
      log('Contract created with ID: ${contractRef.id}');

      contractId = contractRef.id;

      emit(
        ContractSuccess(
            'Contract created successfully! Contract ID: $contractId'),
      );
    } catch (e) {
      log('Failed to create contract: $e');
      emit(
        ContractError('Failed to create contract: ${e.toString()}'),
      );
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
      Query query = _firestore.collection('contracts').where('creatorId',
          isEqualTo: userId); // Filter by creatorId or otherUserId
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

  /// Fetch buyerId and sellerId for a given contract
  Future<Map<String, String>> getBuyerAndSellerIds(String contractId) async {
    try {
      final doc =
          await _firestore.collection('contracts').doc(contractId).get();
      if (!doc.exists) {
        emit(const ContractError('Contract not found.'));
        return {};
      }

      final data = doc.data() as Map<String, dynamic>;
      final buyerId = data['buyerData']['id'] as String? ?? '';
      final sellerId = data['sellerData']['id'] as String? ?? '';

      return {
        'buyerId': buyerId,
        'sellerId': sellerId,
      };
    } catch (e) {
      emit(ContractError(
          'Failed to fetch buyer and seller IDs: ${e.toString()}'));
      return {};
    }
  }

  String getContractId() {
    return contractId;
  }

  String enteredUserId = ''; // Define the enteredUserId variable

  String getEnteredUserId() {
    return enteredUserId;
  }
}
