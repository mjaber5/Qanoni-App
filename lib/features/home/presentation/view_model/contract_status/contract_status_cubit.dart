import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'contract_status_state.dart';

class ContractCubit extends Cubit<ContractStatusState> {
  ContractCubit() : super(ContractStatusInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _enteredUserId = '';
  String _contractId = '';

  /// Create a new contract
  Future<void> createContract({
    required Map<String, String> buyerInfo,
    required Map<String, String> sellerInfo,
    required Map<String, String> carInfo,
    required Map<String, String> signatures,
  }) async {
    if ([buyerInfo, sellerInfo, carInfo, signatures]
        .any((map) => map.isEmpty)) {
      _emitError('Invalid input: Missing data.');
      return;
    }

    emit(ContractLoading());
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        _emitError('User not logged in.');
        return;
      }

      // Generate a unique contract ID
      final contractId = _firestore.collection('contracts').doc().id;

      // Contract data
      final contractData = {
        'buyerInfo': buyerInfo,
        'sellerInfo': sellerInfo,
        'carInfo': carInfo,
        'signatures': signatures,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'userId': currentUser.uid,
      };

      // Save contract to Firestore
      await _firestore
          .collection('contracts')
          .doc(contractId)
          .set(contractData);
      _contractId = contractId;

      emit(ContractSuccess(
          'Contract created successfully! Contract ID: $contractId'));
      log('Contract created successfully: $contractId');
    } catch (e) {
      _emitError('Failed to create contract: $e');
    }
  }

  /// Save seller information
  Future<void> saveSeller({
    required String fullName,
    required String birthDate,
    required String nationalID,
    required String registryNumber,
    required String registryPlace,
    required String expiryDate,
  }) async {
    if ([
      fullName,
      birthDate,
      nationalID,
      registryNumber,
      registryPlace,
      expiryDate
    ].any((field) => field.isEmpty)) {
      _emitError('Invalid input: Missing seller data.');
      return;
    }

    if (_contractId.isEmpty) {
      _emitError('No active contract to save seller information.');
      return;
    }

    emit(ContractLoading());
    try {
      final sellerInfo = {
        'fullName': fullName,
        'birthDate': birthDate,
        'nationalID': nationalID,
        'registryNumber': registryNumber,
        'registryPlace': registryPlace,
        'expiryDate': expiryDate,
      };

      await _firestore.collection('contracts').doc(_contractId).update({
        'sellerInfo': sellerInfo,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      emit(const ContractUpdated('Seller information saved successfully.'));
      log('Seller information saved for contract: $_contractId');
    } catch (e) {
      _emitError('Failed to save seller information: $e');
    }
  }

  /// Update specific fields in the contract
  Future<void> _updateContractField({
    required String contractId,
    required String fieldKey,
    required Map<String, String> data,
    required String successMessage,
    required String errorMessage,
  }) async {
    if (contractId.isEmpty || data.isEmpty) {
      _emitError('Invalid input: Contract ID or $fieldKey data is empty.');
      return;
    }

    emit(ContractLoading());
    try {
      await _firestore.collection('contracts').doc(contractId).update({
        fieldKey: data,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      emit(ContractUpdated(successMessage));
      log(successMessage);
    } catch (e) {
      _emitError('$errorMessage: $e');
    }
  }

  /// Update buyer information
  Future<void> updateBuyerInfo({
    required String contractId,
    required Map<String, String> buyerInfo,
  }) async {
    await _updateContractField(
      contractId: contractId,
      fieldKey: 'buyerInfo',
      data: buyerInfo,
      successMessage: 'Buyer information updated successfully.',
      errorMessage: 'Failed to update buyer information',
    );
  }

  /// Update car information
  Future<void> updateCarInfo({
    required String contractId,
    required Map<String, String> carInfo,
  }) async {
    await _updateContractField(
      contractId: contractId,
      fieldKey: 'carInfo',
      data: carInfo,
      successMessage: 'Car information updated successfully.',
      errorMessage: 'Failed to update car information',
    );
  }

  /// Update signatures
  Future<void> updateSignatures({
    required String contractId,
    required Map<String, String> signatures,
  }) async {
    await _updateContractField(
      contractId: contractId,
      fieldKey: 'signatures',
      data: signatures,
      successMessage: 'Signatures updated successfully.',
      errorMessage: 'Failed to update signatures',
    );
  }

  /// Set the entered user ID
  void setUserIduse(String userIduse) {
    if (userIduse.isEmpty) {
      _emitError('Entered user Iduse is empty.');
      return;
    }

    _enteredUserId = userIduse;
    emit(ContractUserIdUpdated(userIduse));
  }

  /// Getters
  String getEnteredUserIduse() => _enteredUserId;
  String getContractId() => _contractId;

  /// Emit an error state with a message
  void _emitError(String message) {
    emit(ContractError(message));
    log('Error: $message');
  }
}
