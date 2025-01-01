part of 'notifications_cubit.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {}

class NotificationLoading extends NotificationsState {}

class NotificationInitialized extends NotificationsState {}

class NotificationClicked extends NotificationsState {
  final String contractId;

  const NotificationClicked(this.contractId);
}

class NotificationError extends NotificationsState {
  final String error;

  const NotificationError(this.error);
}

class NotificationsFetched extends NotificationsState {
  final List<Map<String, String>> notifications;

  const NotificationsFetched(this.notifications);

  @override
  List<Object> get props => [notifications];
}

class ContractCreated extends NotificationsState {
  const ContractCreated();

  @override
  List<Object> get props => [];
}
