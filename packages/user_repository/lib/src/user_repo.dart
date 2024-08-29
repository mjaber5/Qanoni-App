import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/models.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<MyUsers> signUp(MyUsers myUser, String password);

  Future<void> setUserData(MyUsers user);

  Future<void> signIn(String email, String password);
}
