part of 'contract_status_cubit.dart';

sealed class ContractStatusState extends Equatable {
  const ContractStatusState();

  @override
  List<Object> get props => [];
}

final class ContractStatusInitial extends ContractStatusState {}

class ContractLoading extends ContractStatusState {}

class ContractSuccess extends ContractStatusState {
  final String message;
  const ContractSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ContractError extends ContractStatusState {
  final String error;
  const ContractError(this.error);

  @override
  List<Object> get props => [error];
}

class ContractUpdated extends ContractStatusState {
  final String response;
  const ContractUpdated(this.response);

  @override
  List<Object> get props => [response];
}

class ContractUserIdUpdated extends ContractStatusState {
  final String userId;
  const ContractUserIdUpdated(this.userId);

  @override
  List<Object> get props => [userId];
}
