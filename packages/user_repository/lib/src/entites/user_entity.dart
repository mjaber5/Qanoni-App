import 'package:equatable/equatable.dart';

class MyUsersEntity extends Equatable {
  final String userId;
  final String email;
  final String userName;
  final String phone;

  const MyUsersEntity({
    required this.phone,
    required this.userId,
    required this.email,
    required this.userName,
  });

  Map<String, Object?> toDocument() {
    return {
      'phone': phone,
      'userId': userId,
      'email': email,
      'userName': userName,
    };
  }

  static MyUsersEntity fromDocument(Map<String, dynamic> doc) {
    return MyUsersEntity(
      phone: doc['phone'],
      userId: doc['userId'],
      email: doc['email'],
      userName: doc['userName'],
    );
  }

  @override
  List<Object?> get props => [userId, userName, phone, email];
}
