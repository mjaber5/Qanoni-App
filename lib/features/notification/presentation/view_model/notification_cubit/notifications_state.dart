part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationLoading extends NotificationsState {}

class NotificationInitialized extends NotificationsState {}

class NotificationClicked extends NotificationsState {
  final String contractId;

  const NotificationClicked(this.contractId);

  @override
  List<Object?> get props => [contractId];
}

class NotificationReceived extends NotificationsState {
  final Map<String, dynamic> notificationData;

  const NotificationReceived(this.notificationData);

  @override
  List<Object?> get props => [notificationData];
}

class NotificationsFetched extends NotificationsState {
  final List<Map<String, String>> messages;

  const NotificationsFetched(this.messages);

  @override
  List<Object?> get props => [messages];
}

class NotificationError extends NotificationsState {
  final String error;

  const NotificationError(this.error);

  @override
  List<Object?> get props => [error];
}

class ContractCreated extends NotificationsState {
  const ContractCreated();
}
