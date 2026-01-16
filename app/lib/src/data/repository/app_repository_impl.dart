import 'package:app/src/data/local/data_source/app_local_data_source.dart';
import 'package:app/src/domain/repository/app_repository.dart';
import 'package:core/core.dart';

class AppRepositoryImpl implements AppRepository {
  final AppLocalDataSource _appLocalDataSource;

  AppRepositoryImpl({required AppLocalDataSource appLocalDataSource})
    : _appLocalDataSource = appLocalDataSource;

  @override
  AsyncResult<List<String>> getSearchSuggestions() async {
    return await _appLocalDataSource.getSearchSuggestions();
  }

  @override
  AsyncResult<bool?> getThemeMode() async {
    return await _appLocalDataSource.getThemeMode();
  }

  @override
  AsyncResult<void> setSearchSuggestions({
    required List<String> suggestions,
  }) async {
    return await _appLocalDataSource.setSearchSuggestions(
      suggestions: suggestions,
    );
  }

  @override
  AsyncResult<void> setThemeMode({required bool isDarkMode}) async {
    return await _appLocalDataSource.setThemeMode(isDarkMode: isDarkMode);
  }

  @override
  AsyncResult<void> updateSearchSuggestions({required String value}) async {
    return await _appLocalDataSource.updateSearchSuggestions(value: value);
  }
}
