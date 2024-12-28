import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/features/home/presentation/view_model/contract_status/contract_status_cubit.dart';

import 'all.dart';
import 'done.dart';
import 'request.dart';

class NotificationContent extends StatefulWidget {
  const NotificationContent({super.key});

  @override
  State<NotificationContent> createState() => NotificationContentState();
}

class NotificationContentState extends State<NotificationContent> {
  String selectedItem = "All";
  final PageController _pageController = PageController();

  // Firebase Messaging instance
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Local Notifications plugin
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    // Request permission for notifications
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await _localNotificationsPlugin.initialize(initializationSettings);

    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Foreground message received: ${message.notification?.title}');
      _showNotification(message.notification);
    });

    // Handle notification when app is opened via notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(message.data);
    });

    // Get the FCM token for this device
    String? token = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $token");
  }

  void _showNotification(RemoteNotification? notification) {
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel', // Channel ID
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    _localNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
    );
  }

  void _handleNotificationClick(Map<String, dynamic> data) {
    // Handle notification click logic, e.g., navigate to a specific screen
    if (data['type'] == 'request') {
      _pageController.jumpToPage(1); // Jump to "Request" tab
    } else if (data['type'] == 'done') {
      _pageController.jumpToPage(2); // Jump to "Done" tab
    }
  }

  Widget buildTab(String label, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedItem = label;
          _pageController.jumpToPage(index);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color:
                selectedItem == label ? QColors.secondary : Colors.transparent,
            border: Border.all(
              color: selectedItem == label
                  ? QColors.secondary
                  : Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
              width: selectedItem == label ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(
                color: selectedItem == label
                    ? Colors.white
                    : Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 4),
            buildTab("All", 0),
            const SizedBox(width: 4),
            buildTab("Request", 1),
            const SizedBox(width: 4),
            buildTab("Progress status", 2),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                if (index == 0) {
                  selectedItem = "All";
                } else if (index == 1) {
                  selectedItem = "Request";
                } else if (index == 2) {
                  selectedItem = "Progress status";
                }
              });
            },
            children: [
              const All(),
              BlocBuilder<ContractCubit, ContractStatusState>(
                builder: (context, state) {
                  String enteredUserId =
                      context.read<ContractCubit>().getEnteredUserId();
                  String contractId =
                      context.read<ContractCubit>().getContractId();
                  return FutureBuilder<Map<String, String>>(
                    future: context
                        .read<ContractCubit>()
                        .getBuyerAndSellerIds(contractId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        String buyerId = snapshot.data!['buyerId']!;
                        String sellerId = snapshot.data!['sellerId']!;

                        // Return the Request widget with buyerId and sellerId
                        return Request(
                          enteredUserId: enteredUserId,
                          contractId: contractId,
                          buyerId: buyerId,
                          sellerId: sellerId,
                        );
                      } else {
                        return const Text('No data available');
                      }
                    },
                  );
                },
              ),
              const Done(),
            ],
          ),
        ),
      ],
    );
  }
}
