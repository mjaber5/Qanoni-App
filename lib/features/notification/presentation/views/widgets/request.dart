import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../home/presentation/views/widget/seller_cuntract.dart';
import '../../../../home/presentation/views/widget/buyer_cuntract.dart';

class Request extends StatefulWidget {
  final String enteredUserId;
  final String contractId;

  const Request({
    super.key,
    required this.enteredUserId,
    required this.contractId,
  });

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final List<Map<String, String>> _notifications = [];
  late FirebaseMessaging _firebaseMessaging;
  bool _isMounted = true; // To track if the widget is still mounted

  String sellerId = "seller123"; // Example seller ID, replace with actual logic
  String buyerId = "buyer456"; // Example buyer ID, replace with actual logic

  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging.instance;
    _initializeFirebaseMessaging();

    // Simulate sending a notification to the entered user
    _simulateSendNotificationToUser(widget.enteredUserId, widget.contractId);
  }

  void _initializeFirebaseMessaging() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Foreground message received: ${message.notification?.title}');
      _showInAppNotification(message.notification);
      _handleIncomingMessage(message.notification);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Notification clicked: ${message.notification?.title}');
      _handleIncomingMessage(message.notification);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    String? token = await _firebaseMessaging.getToken();
    log('FCM Token: $token');
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log('Handling a background message: ${message.notification?.title}');
  }

  void _handleIncomingMessage(RemoteNotification? notification) {
    if (notification == null) return;

    if (!_isMounted) return;

    setState(() {
      _notifications.add({
        'title': notification.title ?? 'No Title',
        'body': notification.body ?? 'No Content',
      });
    });
  }

  void _showInAppNotification(RemoteNotification? notification) {
    if (notification == null) return;

    if (!_isMounted) return;

    final snackBar = SnackBar(
      content: Text(
        notification.title ?? 'You have a new message!',
        style: const TextStyle(fontSize: 16),
      ),
      action: SnackBarAction(
        label: 'View',
        onPressed: () {
          _handleIncomingMessage(notification);
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _simulateSendNotificationToUser(String userId, String contractId) {
    Future.delayed(const Duration(seconds: 2), () {
      if (!_isMounted) return;

      setState(() {
        _notifications.add({
          'title': 'New Contract Created',
          'body':
              'A new contract (ID: $contractId) has been created for user $userId.',
        });
      });

      log('Notification sent to user $userId about contract $contractId.');
    });
  }

  Widget buildNotificationList(BuildContext context) {
    if (_notifications.isEmpty) {
      return Center(
        child: Text(
          "No Requests",
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.request_page, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification['title'] ?? "Request Notification",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            notification['body'] ?? "No additional details",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        log('Reject notification at index $index');
                        setState(() {
                          _notifications.removeAt(index);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Reject',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        log('Approve contract ${widget.contractId}');
                        if (widget.enteredUserId == sellerId) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BuyerCuntract()),
                          );
                        } else if (widget.enteredUserId == buyerId) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SellerCuntract()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Unable to determine contract type.')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Approve',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildNotificationList(context),
    );
  }
}
