import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:qanoni/core/services/base.dart';
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

  /// Fetch user messages from the server
  Future<void> fetchUserMessages(String userIduse) async {
    emit(NotificationLoading());
    try {
      final url = '${ConfigApi.baseUri}/get-messages/$userIduse';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final messages = jsonDecode(response.body) as List;
        emit(NotificationsFetched(messages.cast<Map<String, String>>()));
      } else {
        log('Failed to retrieve messages: ${response.body}');
        emit(const NotificationError('Failed to retrieve messages.'));
      }
    } catch (e) {
      log('Error retrieving messages: $e');
      emit(const NotificationError('Error retrieving messages.'));
    }
  }

  /// Initialize notifications for the user
  Future<void> initializeNotifications(String? userId) async {
    if (userId == null || userId.isEmpty) {
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
        emit(const NotificationError('Notification permissions denied.'));
        return;
      }

      log('Notification permission status: ${settings.authorizationStatus}');

      // Register background message handler
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Handle foreground notifications
      FirebaseMessaging.onMessage.listen(_handleForegroundNotification);

      // Save and update FCM token
      final token = await _firebaseMessaging.getToken();
      if (token == null) {
        emit(const NotificationError('Failed to retrieve FCM token.'));
        return;
      }
      await _userRepository.updateFcmToken(userId, token);

      emit(NotificationInitialized());
    } catch (e) {
      log('Error initializing notifications: $e');
      emit(const NotificationError('Error initializing notifications.'));
    }
  }

  /// Initialize local notification settings
  Future<void> _initializeLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: androidSettings);

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          handleNotificationClick(response.payload!);
        }
      },
    );

    // Create notification channel for Android 8.0+
    const androidNotificationChannel = AndroidNotificationChannel(
      'high_importance_channel', // Channel ID
      'High Importance Notifications', // Channel Name
      description: 'This channel is for important notifications.',
      importance: Importance.high,
    );

    final androidPlugin =
        _localNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(androidNotificationChannel);
    }

    log('Local notifications initialized successfully.');
  }

  /// Handle foreground notifications
  void _handleForegroundNotification(RemoteMessage message) {
    log('Foreground message received: ${message.notification?.title}');
    if (message.notification != null) {
      _showLocalNotification(
        title: message.notification!.title ?? 'No Title',
        body: message.notification!.body ?? 'No Body',
        payload: message.data['contractId'], // Optional payload
      );
    } else {
      log('Message does not contain notification details.');
    }
  }

  /// Show a local notification
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel', // Ensure this matches the channel ID
      'High Importance Notifications',
      channelDescription: 'This channel is for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    try {
      await _localNotificationsPlugin.show(
        DateTime.now().millisecond, // Unique Notification ID
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    } catch (e) {
      log('Error showing local notification: $e');
    }
  }

  /// Handle notification click
  void handleNotificationClick(String contractId) {
    log('Notification clicked with payload: $contractId');
    emit(NotificationClicked(contractId));
  }

  /// Create a contract and notify the other user
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

      // Create a new contract
      final contractRef = await _firestore.collection('contracts').add({
        'creatorId': user.userId,
        'userType': userType,
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
      });

      final contractId = contractRef.id;
      log('Contract created with ID: $contractId');

      // Send notification to the user using `userIduse`
      await _sendNotification(otherUserIduse, contractId);
      emit(const ContractCreated());
    } catch (e) {
      log('Error creating contract or sending notification: $e');
      emit(const NotificationError(
          'Error creating contract or sending notification.'));
    }
  }

  /// Send notification to the user by `userIduse`
  Future<void> _sendNotification(String userIduse, String contractId) async {
    try {
      const url = '${ConfigApi.baseUri}/send-notification';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userIduse': userIduse,
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

  /// Background message handler (static for background execution)
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log('Handling a background message: ${message.messageId}');
    // Additional background handling if needed
  }
}
