part of 'contract_status_cubit.dart';

/// Base class for all Contract states.
sealed class ContractStatusState extends Equatable {
  const ContractStatusState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the contract feature is not yet active.
final class ContractStatusInitial extends ContractStatusState {}

/// Loading state to indicate a process is in progress.
final class ContractLoading extends ContractStatusState {}

/// Success state to indicate a successful operation.
final class ContractSuccess extends ContractStatusState {
  final String message;

  const ContractSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Error state to indicate an operation has failed.
final class ContractError extends ContractStatusState {
  final String error;

  const ContractError(this.error);

  @override
  List<Object?> get props => [error];
}

/// State to indicate that a contract has been successfully updated.
final class ContractUpdated extends ContractStatusState {
  final String response;

  const ContractUpdated(this.response);

  @override
  List<Object?> get props => [response];
}

/// State to indicate that the user's ID has been updated.
final class ContractUserIdUpdated extends ContractStatusState {
  final String userId;

  const ContractUserIdUpdated(this.userId);

  @override
  List<Object?> get props => [userId];
}
