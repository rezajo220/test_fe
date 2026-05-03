import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String username;
  final String department;
  final String jabatan;

  const UserEntity({
    required this.email,
    required this.username,
    required this.department,
    required this.jabatan,
  });

  @override
  List<Object?> get props => [email, username, department, jabatan];
}