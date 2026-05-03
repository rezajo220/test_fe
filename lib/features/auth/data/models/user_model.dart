import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.email,
    required super.username,
    required super.department,
    required super.jabatan,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      department: json['department'] ?? '',
      jabatan: json['jabatan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'department': department,
        'jabatan': jabatan,
      };
}