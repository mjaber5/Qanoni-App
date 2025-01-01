import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:user_repository/user_reposetory.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final FirebaseMessaging _firebaseMessaging;
  final FirebaseFirestore _firestore;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  final UserRepository _userRepository;

  NotificationsCubit(
    this._firebaseMessaging,
    this._firestore,
    this._localNotificationsPlugin,
    this._userRepository,
  ) : super(NotificationsInitial());

  // Fetch user messages
  Future<void> fetchUserMessages(String userIduse) async {
    emit(NotificationLoading());
    try {
      final url =
          'https://acec-2a01-9700-44f2-ed00-59f8-61af-59e9-9a3a.ngrok-free.app/get-messages/$userIduse';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final messages = jsonDecode(response.body) as List;
        emit(NotificationsFetched(messages.cast<Map<String, String>>()));
      } else {
        log('Failed to retrieve messages: ${response.body}');
        emit(
            NotificationError('Failed to retrieve messages: ${response.body}'));
      }
    } catch (e) {
      log('Error retrieving messages: $e');
      emit(NotificationError('Error retrieving messages: $e'));
    }
  }

  // Initialize notifications
  Future<void> initializeNotifications(String? userId) async {
    if (userId == null || userId.isEmpty) {
      log('Error: User ID is null or empty. Cannot initialize notifications.');
      emit(const NotificationError('User ID is missing.'));
      return;
    }

    try {
      emit(NotificationLoading());

      // Request notification permissions
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        log('Notification permissions denied');
        emit(const NotificationError('Notification permissions denied.'));
        return;
      }

      log('Notification permission status: ${settings.authorizationStatus}');

      // Initialize local notifications
      const initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
      );

      await _localNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          log('Notification clicked with payload: ${response.payload}');
          if (response.payload != null) {
            handleNotificationClick(response.payload!);
          }
        },
      );

      // Save FCM token
      final token = await _firebaseMessaging.getToken();
      if (token == null) {
        log('FCM token is null. Cannot proceed.');
        emit(const NotificationError('Failed to retrieve FCM token.'));
        return;
      }
      log('FCM Token: $token');

      // Update FCM token using UserRepository
      await _userRepository.updateFcmToken(userId, token);

      emit(NotificationInitialized());
    } catch (e) {
      log('Error initializing notifications: $e');
      emit(NotificationError('Error initializing notifications: $e'));
    }
  }

  // Handle notification click
  void handleNotificationClick(String contractId) {
    emit(NotificationClicked(contractId));
  }

  // Create contract and notify
  Future<void> createContractAndNotify(
      String otherUserIduse, String userType) async {
    emit(NotificationLoading());
    try {
      final user = await _userRepository.fetchUserByUserIduse(otherUserIduse);
      if (user == null) {
        emit(NotificationError('User with ID $otherUserIduse not found.'));
        return;
      }

      log('User found: ${user.userId}');

      final contractRef = await _firestore.collection('contracts').add({
        'creatorId': user.userId,
        'userType': userType,
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
      });
      final String contractId = contractRef.id;
      log('Contract created with ID: $contractId');

      final fcmToken = user.fcmToken;
      if (fcmToken != null) {
        await _sendNotification(fcmToken, contractId);
        emit(const ContractCreated());
      } else {
        emit(NotificationError('FCM token not found for user: ${user.userId}'));
      }
    } catch (e) {
      log('Error creating contract or sending notification: $e');
      emit(NotificationError(
          'Error creating contract or sending notification: $e'));
    }
  }

  // Send notification
  Future<void> _sendNotification(String fcmToken, String contractId) async {
    try {
      const url =
          'https://acec-2a01-9700-44f2-ed00-59f8-61af-59e9-9a3a.ngrok-free.app/send-notification';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fcmToken': fcmToken,
          'title': 'New Contract Assigned',
          'body': 'You have a new contract with ID: $contractId',
          'data': {
            'contractId': contractId,
            'type': 'contract',
          },
        }),
      );

      if (response.statusCode == 200) {
        log('Notification sent successfully');
      } else {
        log('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      log('Error sending notification: $e');
    }
  }

  // Fetch contract notifications
  Future<void> fetchContractNotifications(String contractId) async {
    emit(NotificationLoading());
    try {
      log('Fetching notifications for contract ID: $contractId');

      final querySnapshot = await _firestore
          .collection('contracts')
          .doc(contractId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .get();

      final notifications = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'title': (data['title'] ?? 'No Title').toString(),
          'body': (data['body'] ?? 'No Content').toString(),
          'timestamp': (data['timestamp'] as Timestamp?)?.toDate().toString() ??
              'No Timestamp',
        };
      }).toList();

      emit(NotificationsFetched(notifications));
      log('Fetched ${notifications.length} notifications for contract ID: $contractId');
    } catch (e) {
      log('Error fetching notifications for contract ID $contractId: $e');
      emit(NotificationError('Error fetching notifications: $e'));
    }
  }

  // Request notification permissions
  Future<void> requestNotificationPermission() async {
    try {
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        log('Notification permissions denied');
        emit(const NotificationError('Notification permissions denied.'));
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.authorized) {
        log('Notification permissions granted');
        emit(NotificationInitialized());
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        log('Provisional notification permissions granted');
        emit(NotificationInitialized());
      } else {
        log('Unknown notification permission status: ${settings.authorizationStatus}');
        emit(
            const NotificationError('Unknown notification permission status.'));
      }
    } catch (e) {
      log('Error requesting notification permissions: $e');
      emit(NotificationError('Error requesting notification permissions: $e'));
    }
  }
}
