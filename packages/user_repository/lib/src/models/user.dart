import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entites/user_entity.dart';

class MyUsers extends Equatable {
  final String userId;
  final String email;
  final String userName;
  final String phone;
  final String idNumber;

  const MyUsers({
    required this.phone,
    required this.userId,
    required this.email,
    required this.userName,
    required this.idNumber,
  });

  static const empty = MyUsers(
    phone: '',
    userId: '',
    email: '',
    userName: '',
    idNumber: '',
  );

  MyUsers copyWith({
    String? userId,
    String? email,
    String? userName,
    String? phone,
    String? idNumber,
  }) {
    return MyUsers(
      phone: phone ?? this.phone,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      idNumber: idNumber ?? this.idNumber,
    );
  }

  MyUsersEntity toEntity() {
    return MyUsersEntity(
      phone: phone,
      userId: userId,
      email: email,
      userName: userName,
      idNumber: idNumber,
    );
  }

  static MyUsers fromEntity(MyUsersEntity entity) {
    return MyUsers(
      phone: entity.phone,
      userId: entity.userId,
      email: entity.email,
      userName: entity.userName,
      idNumber: entity.idNumber,
    );
  }

  @override
  List<Object?> get props => [userId, email, userName, phone, idNumber];
}
