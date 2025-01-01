import 'dart:developer' as developer;
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:user_repository/user_reposetory.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _updateFcmToken();
    } catch (error) {
      developer.log('Error during sign-in: $error');
      rethrow;
    }
  }

  @override
  Future<MyUsers> signUp(MyUsers myUser, String password) async {
    try {
      // Generate a unique userIduse
      String userIduse = _generateUniqueUserId();

      // Register the user with email and password
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );

      // Update myUser with userId and userIduse
      myUser = myUser.copyWith(
        userId: userCredential.user!.uid,
        userIduse: userIduse,
      );

      // Save user data and FCM token
      await setUserData(myUser);
      await _updateFcmToken(userId: myUser.userId);

      return myUser;
    } catch (error) {
      developer.log('Error during sign-up: $error');
      rethrow;
    }
  }

  // Generate a unique userIduse starting with #
  String _generateUniqueUserId() {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random rand = Random();
    StringBuffer userIdBuffer = StringBuffer('#');

    for (int i = 0; i < 7; i++) {
      userIdBuffer.write(chars[rand.nextInt(chars.length)]);
    }

    return userIdBuffer.toString();
  }

  @override
  Future<void> setUserData(MyUsers myUser) async {
    try {
      await usersCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (error) {
      developer.log('Error saving user data: $error');
      rethrow;
    }
  }

  @override
  Future<void> updateFcmToken(String userId, String fcmToken) async {
    try {
      final docRef = usersCollection.doc(userId);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        throw Exception('No user document found for userId: $userId');
      }

      await docRef.update({'fcmToken': fcmToken});
      developer.log('FCM token updated for user: $userId');
    } catch (error) {
      developer.log('Error updating FCM token: $error');
      rethrow;
    }
  }

  Future<void> _updateFcmToken({String? userId}) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token == null) {
        throw Exception('Failed to retrieve FCM token.');
      }

      final currentUserId = userId ?? _firebaseAuth.currentUser?.uid;
      if (currentUserId == null) {
        throw Exception('User ID is null. Cannot update FCM token.');
      }

      await updateFcmToken(currentUserId, token);
    } catch (error) {
      developer.log('Error updating FCM token: $error');
      rethrow;
    }
  }

  @override
  Future<MyUsers?> fetchUserByUserIduse(String userIduse) async {
    try {
      final querySnapshot = await usersCollection
          .where('userIduse', isEqualTo: userIduse)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        developer.log('No user found with userIduse: $userIduse');
        return null;
      }

      final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
      return MyUsers.fromEntity(MyUsersEntity.fromDocument(data));
    } catch (error) {
      developer.log('Error fetching user by userIduse $userIduse: $error');
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
    developer.log('User logged out successfully.');
  }
}
