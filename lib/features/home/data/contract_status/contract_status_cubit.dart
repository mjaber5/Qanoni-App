import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'contract_status_state.dart';

class ContractCubit extends Cubit<ContractStatusState> {
  ContractCubit() : super(ContractStatusInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String enteredUserId = ''; // This stores the entered user ID

  // Method to create a contract
  Future<void> createContract({
    required String otherUserId,
    required String userType,
    required currentUser,
  }) async {
    emit(ContractLoading());
    try {
      final User? currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        emit(const ContractError('User not logged in.'));
        return;
      }

      // Fetch current user's data from Firestore
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

      // Prepare the contract data to save in Firestore
      final contractData = {
        'sellerId': currentUser.uid,
        'buyerId': otherUserId,
        'status': 'pending',
        'email': currentUserData['email'],
        'userName': currentUserData['userName'],
        'phone': currentUserData['phone'],
        'idNumber': currentUserData['idNumber'],
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Save contract to Firestore
      await _firestore.collection('contracts').add(contractData);

      emit(const ContractSuccess('Contract request sent successfully!'));
    } catch (e) {
      emit(ContractError('Failed to create contract: ${e.toString()}'));
    }
  }

  // Method to respond to a contract (approve/reject)
  Future<void> respondToContract({
    required String contractId,
    required String response,
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

  // Method to fetch contracts for a specific user
  Future<List<Map<String, dynamic>>> fetchContractsForUser({
    required String userId,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('contracts')
          .where('buyerId', isEqualTo: userId)
          .where('status', isEqualTo: 'pending')
          .get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      emit(ContractError('Failed to fetch contracts: ${e.toString()}'));
      return [];
    }
  }

  // Method to set the entered user ID and emit the updated state
  void setUserId(String userId) {
    enteredUserId = userId;
    emit(ContractUserIdUpdated(userId)); // Emit a state with updated user ID
  }

  // Method to get the entered user ID
  String getEnteredUserId() {
    return enteredUserId;
  }
}
