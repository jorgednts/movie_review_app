import 'package:core/core.dart';

class CreateUserStorageRequest {
  final UserModel user;
  final String name;

  CreateUserStorageRequest({required this.user, required this.name});

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'name': name};
  }
}
