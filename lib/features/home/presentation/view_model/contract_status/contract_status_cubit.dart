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

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ContractRepo _contractRepo;

  String _enteredUserId = '';
  String _contractId = '';

  // Save Complete Contract Data
  Future<void> saveCompleteContract({
    required Buyer buyer,
    required Seller seller,
    required CarInfoForm carInfo,
    required ContractInfo contractInfo,
  }) async {
    emit(ContractLoading());
    try {
      final User? currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        emit(const ContractError('User not logged in.'));
        return;
      }

      await _contractRepo.saveContract(
        buyer: buyer,
        seller: seller,
        carInfo: carInfo,
        contractInfo: contractInfo,
        creatorId: currentUser.uid,
      );

      emit(const ContractSuccess('Complete contract saved successfully.'));
    } catch (e) {
      emit(ContractError('Failed to save complete contract: $e'));
    }
  }

  // Get the entered user ID
  String getEnteredUserId() {
    return _enteredUserId;
  }

  // Set the entered user ID
  void setEnteredUserId(String userId) {
    _enteredUserId = userId;
    emit(ContractUserIdUpdated(userId));
  }

  // Get the contract ID
  String getContractId() {
    return _contractId;
  }

  // Set the contract ID
  void setContractId(String contractId) {
    if (contractId.isEmpty) {
      emit(const ContractError('Contract ID cannot be empty.'));
      return;
    }
    _contractId = contractId;
    emit(ContractUpdated('Contract ID updated: $contractId'));
  }

  // Fetch buyer and seller IDs for a given contract
  Future<Map<String, String>> getBuyerAndSellerIds(String contractId) async {
    if (contractId.isEmpty) {
      log('Error: contractId is empty.');
      throw Exception('Invalid contractId.');
    }
    try {
      final doc =
          await _firestore.collection('contracts').doc(contractId).get();
      if (!doc.exists) {
        throw Exception('Contract not found');
      }
      final data = doc.data() as Map<String, dynamic>;
      final buyerId = data['buyer']?['id'] as String? ?? '';
      final sellerId = data['seller']?['id'] as String? ?? '';
      return {'buyerId': buyerId, 'sellerId': sellerId};
    } catch (e) {
      log('Error fetching buyer and seller IDs: $e');
      throw Exception('Failed to fetch buyer and seller IDs: $e');
    }
  }
}
