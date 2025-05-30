import 'package:core/core.dart';

class UserStorageModel {
  final UserModel user;
  final String name;

  UserStorageModel({required this.user, required this.name})
    : assert(name.isNotEmpty);
}
