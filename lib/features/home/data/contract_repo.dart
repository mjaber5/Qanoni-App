import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:qanoni/features/home/data/model/buyer_data.dart';
import 'package:qanoni/features/home/data/model/seller_data.dart';
import 'package:qanoni/features/home/data/model/car_information_data.dart';
import 'package:qanoni/features/home/data/model/contract_information_data.dart';

class ContractRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save Complete Contract Data
  Future<void> saveContract({
    Buyer? buyer,
    Seller? seller,
    CarInfoForm? carInfo,
    ContractInfo? contractInfo,
    required String creatorId,
  }) async {
    try {
      final contractData = {
        if (buyer != null)
          'buyer': {
            'fullName': buyer.fullName,
            'birthDate': buyer.birthDate,
            'nationalID': buyer.nationalID,
            'registryNumber': buyer.registryNumber,
            'registryPlace': buyer.registryPlace,
            'expiryDate': buyer.expiryDate,
          },
        if (seller != null)
          'seller': {
            'fullName': seller.fullName,
            'birthDate': seller.birthDate,
            'nationalID': seller.nationalID,
            'registryNumber': seller.registryNumber,
            'registryPlace': seller.registryPlace,
            'expiryDate': seller.expiryDate,
          },
        if (carInfo != null)
          'carInfo': {
            'carPlateNumber': carInfo.carPlateNumber,
            'vinNumber': carInfo.vinNumber,
            'engineNumber': carInfo.engineNumber,
            'carModel': carInfo.carModel,
            'carColor': carInfo.carColor,
            'carRegistrationNumber': carInfo.carRegistrationNumber,
            'insuranceExpiryDate': carInfo.insuranceExpiryDate,
            'carCondition': carInfo.carCondition,
          },
        if (contractInfo != null)
          'contractInfo': {
            'contractDate': contractInfo.contractDate,
            'contractPlace': contractInfo.contractPlace,
            'saleAmount': contractInfo.saleAmount,
            'paymentMethod': contractInfo.paymentMethod,
            'ownershipTransfer': contractInfo.ownershipTransfer,
            'additionalTerms': contractInfo.additionalTerms,
          },
        'creatorId': creatorId,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await _firestore.collection('contracts').add(contractData);
      log('Complete contract data saved successfully.');
    } catch (e) {
      log('Error saving complete contract data: $e');
      throw Exception('Failed to save complete contract data: $e');
    }
  }

  // Get Buyer and Seller IDs
  Future<Map<String, String>> getBuyerAndSellerIds(String contractId) async {
    try {
      final doc =
          await _firestore.collection('contracts').doc(contractId).get();
      if (!doc.exists) {
        throw Exception('Contract not found');
      }

      final data = doc.data() as Map<String, dynamic>;
      final buyerId = data['buyer']?['id'] as String? ?? '';
      final sellerId = data['seller']?['id'] as String? ?? '';

      return {
        'buyerId': buyerId,
        'sellerId': sellerId,
      };
    } catch (e) {
      log('Error fetching buyer and seller IDs: $e');
      throw Exception('Failed to fetch buyer and seller IDs: $e');
    }
  }
}
