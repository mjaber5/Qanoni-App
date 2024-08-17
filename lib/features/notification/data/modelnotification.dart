class NotificationItem {
  final String username;
  final String time;
  final String avatarUrl;

  NotificationItem({
    required this.username,
    required this.time,
    required this.avatarUrl,
  });
}

List<NotificationItem> sampleNotifications = [
  NotificationItem(
    username: 'User1',
    time: '2h',
    avatarUrl: 'https://via.placeholder.com/150',
  ),
  NotificationItem(
    username: 'User2',
    time: '3h',
    avatarUrl: 'https://via.placeholder.com/150',
  ),
];
