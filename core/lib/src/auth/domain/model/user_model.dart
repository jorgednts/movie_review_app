import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;

  UserModel({required this.uid, required this.email});

  factory UserModel.fromUser(User user) {
    return UserModel(uid: user.uid, email: user.email ?? '');
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(uid: json['uid'] ?? '', email: json['email'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email};
  }
}
