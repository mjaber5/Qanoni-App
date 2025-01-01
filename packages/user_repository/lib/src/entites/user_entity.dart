import 'package:equatable/equatable.dart';

class MyUsersEntity extends Equatable {
  final String userId;
  final String userIduse;
  final String email;
  final String userName;
  final String phone;
  final String idNumber;
  final String? fcmToken;

  const MyUsersEntity({
    required this.phone,
    required this.userId,
    required this.userIduse,
    required this.email,
    required this.userName,
    required this.idNumber,
    this.fcmToken,
  });

  Map<String, Object?> toDocument() {
    return {
      'phone': phone,
      'userId': userId,
      'userIduse': userIduse,
      'email': email,
      'userName': userName,
      'idNumber': idNumber,
      'fcmToken': fcmToken,
    };
  }

  static MyUsersEntity fromDocument(Map<String, dynamic> doc) {
    return MyUsersEntity(
      phone: doc['phone'],
      userId: doc['userId'],
      userIduse: doc['userIduse'],
      email: doc['email'],
      userName: doc['userName'],
      idNumber: doc['idNumber'],
      fcmToken: doc['fcmToken'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        userName,
        phone,
        email,
        userIduse,
        userId,
        fcmToken,
      ];
}
