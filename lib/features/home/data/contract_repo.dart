import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qanoni/features/home/data/model/buyer_data.dart';
import 'package:qanoni/features/home/data/model/car_information_data.dart';
import 'package:qanoni/features/home/data/model/contract_information_data.dart';
import 'package:qanoni/features/home/data/model/seller_data.dart';

class ContractRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to create a Seller instance
  Seller createSeller({
    required String fullName,
    required String birthDate,
    required String nationalID,
    required String registryNumber,
    required String registryPlace,
    required String expiryDate,
  }) {
    return Seller(
      fullName: fullName,
      birthDate: birthDate,
      nationalID: nationalID,
      registryNumber: registryNumber,
      registryPlace: registryPlace,
      expiryDate: expiryDate,
    );
  }

  // Method to create a Buyer instance
  Buyer createBuyer({
    required String fullName,
    required String birthDate,
    required String nationalID,
    required String registryNumber,
    required String registryPlace,
    required String expiryDate,
  }) {
    return Buyer(
      fullName: fullName,
      birthDate: birthDate,
      nationalID: nationalID,
      registryNumber: registryNumber,
      registryPlace: registryPlace,
      expiryDate: expiryDate,
    );
  }

  // Method to create a CarInfoForm instance
  CarInfoForm createCarInfoForm({
    required String carPlateNumber,
    required String vinNumber,
    required String engineNumber,
    required String carModel,
    required String carColor,
    required String carRegistrationNumber,
    required String insuranceExpiryDate,
    required String carCondition,
  }) {
    return CarInfoForm(
      carPlateNumber: carPlateNumber,
      vinNumber: vinNumber,
      engineNumber: engineNumber,
      carModel: carModel,
      carColor: carColor,
      carRegistrationNumber: carRegistrationNumber,
      insuranceExpiryDate: insuranceExpiryDate,
      carCondition: carCondition,
    );
  }

  // Method to create a ContractInfo instance
  ContractInfo createContractInfo({
    required String contractDate,
    required String contractPlace,
    required String saleAmount,
    required String paymentMethod,
    required bool ownershipTransfer,
    required String additionalTerms,
  }) {
    return ContractInfo(
      contractDate: contractDate,
      contractPlace: contractPlace,
      saleAmount: saleAmount,
      paymentMethod: paymentMethod,
      ownershipTransfer: ownershipTransfer,
      additionalTerms: additionalTerms,
    );
  }

  // Method to save contract data in Firestore with the specified structure
  Future<DocumentReference> saveContract({
    Buyer? buyer,
    Seller? seller,
    CarInfoForm? carInfo,
    ContractInfo? contractInfo,
    String? creatorId,
    String? otherUserId,
    String? userType,
  }) async {
    try {
      final contractData = {
        'buyerData': userType == 'buyer' ? buyer?.toMap() : {},
        'sellerData': userType == 'seller' ? seller?.toMap() : {},
        'carInfo': carInfo?.toMap() ?? {}, // Ensure carInfo is not null
        'contractInfo':
            contractInfo?.toMap() ?? {}, // Ensure contractInfo is not null
        'timestamp': FieldValue.serverTimestamp(),
        'creatorId': creatorId ?? 'unknown_creator', // Provide a fallback value
        'otherUserId':
            otherUserId ?? 'unknown_other_user', // Provide a fallback value
        'status': 'pending',
      };

      // Log the data being saved
      log('Saving contract data: $contractData');

      // Add the data to the "contracts" collection
      final documentRef =
          await _firestore.collection('contracts').add(contractData);

      // Ensure the DocumentReference is not null
      if (documentRef.id.isEmpty) {
        throw Exception('Failed to retrieve the document ID after creation.');
      }

      return documentRef;
    } catch (e) {
      throw Exception('Failed to save contract data: $e');
    }
  }

  // Method to update contract data in Firestore
  Future<void> updateContract({
    required String contractId,
    Map<String, dynamic>? buyerData,
    Map<String, dynamic>? sellerData,
    Map<String, dynamic>? carInfo,
    Map<String, dynamic>? contractInfo,
    String? status, // Optional status update
  }) async {
    try {
      final updateData = <String, dynamic>{};

      if (buyerData != null) {
        updateData['buyerData'] = buyerData;
      }
      if (sellerData != null) {
        updateData['sellerData'] = sellerData;
      }
      if (carInfo != null) {
        updateData['carInfo'] = carInfo;
      }
      if (contractInfo != null) {
        updateData['contractInfo'] = contractInfo;
      }
      if (status != null) {
        updateData['status'] = status;
      }

      // Update the contract document in Firestore
      await _firestore
          .collection('contracts')
          .doc(contractId)
          .update(updateData);
    } catch (e) {
      throw Exception('Failed to update contract data: $e');
    }
  }
}
