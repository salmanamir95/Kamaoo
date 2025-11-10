import 'package:ecommerce_app/app/data/models/user_model.dart';

class UserDto {
  final String uid;
  final String name;
  final String email;
  final String role;

  UserDto(
      {required this.uid,
      required this.name,
      required this.email,
      required this.role});

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
    };
  }

  UserModel toUserModel() {
    return UserModel(
      uid: uid,
      name: name,
      email: email,
      role: role,
    );
  }
}
