import 'package:flutter/foundation.dart';

import '../auth.dart';

class AuthChangeNotifier extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  String? get uid => _user?.uid;

  void setUser(UserModel? userModel) {
    _user = userModel;
    notifyListeners();
  }

  bool get isLoggedIn => _user != null;
}
