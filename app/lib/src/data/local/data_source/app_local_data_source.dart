import 'package:core/core.dart';

abstract class AppLocalDataSource {
  AsyncResult<void> setThemeMode({required bool isDarkMode});

  AsyncResult<bool> getThemeMode();

  AsyncResult<void> updateSearchSuggestions({required String value});

  AsyncResult<void> setSearchSuggestions({required List<String> suggestions});

  AsyncResult<List<String>> getSearchSuggestions();
}
