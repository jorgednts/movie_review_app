import 'package:core/core.dart';

class UserStorageChangeNotifier extends AuthChangeNotifier {
  UserStorageModel? _userStorageModel;

  UserStorageModel? get userStorageModel => _userStorageModel;

  void setUserStorageModel(UserStorageModel value) {
    if (user != null) {
      _userStorageModel = value;
      notifyListeners();
    } else {
      throw NullCollectionException();
    }
  }
}
