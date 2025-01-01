import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/models.dart';

abstract class UserRepository {
  /// Stream to listen for authentication state changes
  Stream<User?> get user;

  /// Sign up a new user with the given data and password
  Future<MyUsers> signUp(MyUsers myUser, String password);

  /// Save or update user data in the database
  Future<void> setUserData(MyUsers user);

  /// Sign in an existing user with email and password
  Future<void> signIn(String email, String password);

  /// Log out the currently signed-in user
  Future<void> logOut();

  /// Update the FCM token for a user
  Future<void> updateFcmToken(String userId, String fcmToken);

  /// Fetch a user by their unique `userIduse`
  Future<MyUsers?> fetchUserByUserIduse(String userIduse);
}
