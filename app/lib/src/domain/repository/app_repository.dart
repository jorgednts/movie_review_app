import 'package:core/core.dart';

abstract class AppRepository {
  Future<Result<void>> setThemeMode({required bool isDarkMode});

  Future<Result<bool>> getThemeMode();

  Future<Result<void>> updateSearchSuggestions({required String value});

  Future<Result<void>> setSearchSuggestions({
    required List<String> suggestions,
  });

  Future<Result<List<String>>> getSearchSuggestions();
}
