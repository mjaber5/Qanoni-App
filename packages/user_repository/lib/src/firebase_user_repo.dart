import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:user_repository/src/user_repo.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

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
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<MyUsers> signUp(MyUsers myUser, String password) async {
    try {
      // توليد ID عشوائي باستخدام الدالة التالية
      String userIduse = _generateUniqueUserId(); // توليد userIduse فريد

      // تسجيل المستخدم باستخدام البريد الإلكتروني وكلمة المرور
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );

      // تحديث myUser ليشمل userId و userIduse
      myUser = myUser.copyWith(
        userId: userCredential.user!.uid,  // إضافة userId من Firebase
        userIduse: userIduse, // إضافة userIduse الفريد
      );

      await setUserData(myUser);

      return myUser;
    } catch (error) {
      rethrow;
    }
  }

  // دالة لتوليد userIduse فريد يبدأ بـ #
  String _generateUniqueUserId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random rand = Random();
    StringBuffer userIdBuffer = StringBuffer('#');

    // توليد 7 خانات عشوائية
    for (int i = 0; i < 7; i++) {
      userIdBuffer.write(chars[rand.nextInt(chars.length)]);
    }

    return userIdBuffer.toString();
  }

  @override
  Future<void> setUserData(MyUsers myUser) async {
    try {
      await usersCollection
          .doc(myUser.userId)  // استخدام userId الفريد من Firebase
          .set(myUser.toEntity().toDocument());
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
