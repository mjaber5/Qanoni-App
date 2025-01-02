import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qanoni/features/home/data/contract_repo.dart';

part 'contract_status_state.dart';

class ContractCubit extends Cubit<ContractStatusState> {
  final ContractRepo _contractRepo;

  ContractCubit(this._contractRepo) : super(ContractStatusInitial());

  Future<void> createContract({
    required String buyerIduse,
    required String sellerIduse,
    required Map<String, dynamic> contractDetails,
  }) async {
    emit(ContractLoading());
    try {
      await _contractRepo.createContract(
        buyerIduse: buyerIduse,
        sellerIduse: sellerIduse,
        contractDetails: contractDetails,
      );
      emit(const ContractSuccess('Contract created successfully.'));
    } catch (e) {
      emit(ContractError('Failed to create contract: $e'));
    }
  }

  Future<void> approveContract(String contractId) async {
    emit(ContractLoading());
    try {
      await _contractRepo.approveContract(contractId);
      emit(const ContractSuccess('Contract approved successfully.'));
    } catch (e) {
      emit(ContractError('Failed to approve contract: $e'));
    }
  }

  Future<void> rejectContract(String contractId) async {
    emit(ContractLoading());
    try {
      await _contractRepo.rejectContract(contractId);
      emit(const ContractSuccess('Contract rejected successfully.'));
    } catch (e) {
      emit(ContractError('Failed to reject contract: $e'));
    }
  }
}
