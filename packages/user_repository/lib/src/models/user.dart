import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entites/user_entity.dart';

class MyUsers extends Equatable {
  final String userId; // Firebase ID (already exists)
  final String userIduse; // Visible ID for dialogs
  final String email;
  final String userName;
  final String phone;
  final String idNumber;

  const MyUsers({
    required this.userId,
    required this.userIduse,
    required this.email,
    required this.userName,
    required this.phone,
    required this.idNumber,
  });

  static const empty = MyUsers(
    userId: '',
    userIduse: '',
    email: '',
    userName: '',
    phone: '',
    idNumber: '',
  );

  MyUsers copyWith({
    String? userId,
    String? userIduse,
    String? email,
    String? userName,
    String? phone,
    String? idNumber,
  }) {
    return MyUsers(
      userId: userId ?? this.userId,
      userIduse: userIduse ?? this.userIduse,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      phone: phone ?? this.phone,
      idNumber: idNumber ?? this.idNumber,
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
    );
  }

  @override
  List<Object?> get props => [userId, userIduse, email, userName, phone, idNumber];
}
