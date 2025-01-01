import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entites/user_entity.dart';

class MyUsers extends Equatable {
  final String userId; // Firebase ID (already exists)
  final String userIduse; // Visible ID for dialogs
  final String email;
  final String userName;
  final String phone;
  final String idNumber;
  final String? fcmToken;

  const MyUsers({
    required this.userId,
    required this.userIduse,
    required this.email,
    required this.userName,
    required this.phone,
    required this.idNumber,
    this.fcmToken,
  });

  static const empty = MyUsers(
    userId: '',
    userIduse: '',
    email: '',
    userName: '',
    phone: '',
    idNumber: '',
    fcmToken: '',
  );

  MyUsers copyWith({
    String? userId,
    String? userIduse,
    String? email,
    String? userName,
    String? phone,
    String? idNumber,
    String? fcmToken,
  }) {
    return MyUsers(
      userId: userId ?? this.userId,
      userIduse: userIduse ?? this.userIduse,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      phone: phone ?? this.phone,
      idNumber: idNumber ?? this.idNumber,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  MyUsersEntity toEntity() {
    return MyUsersEntity(
      userId: userId,
      userIduse: userIduse,
      email: email,
      userName: userName,
      phone: phone,
      idNumber: idNumber,
      fcmToken: fcmToken,
    );
  }

  static MyUsers fromEntity(MyUsersEntity entity) {
    return MyUsers(
      userId: entity.userId,
      userIduse: entity.userIduse, // Extract visible ID
      email: entity.email,
      userName: entity.userName,
      phone: entity.phone,
      idNumber: entity.idNumber,
      fcmToken: entity.fcmToken,
    );
  }

  @override
  List<Object?> get props =>
      [userId, userIduse, email, userName, phone, idNumber, fcmToken];
}
