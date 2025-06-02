import 'package:app/src/data/local/data_source/app_local_data_source.dart';
import 'package:app/src/domain/repository/app_repository.dart';
import 'package:core/core.dart';

class AppRepositoryImpl implements AppRepository {
  final AppLocalDataSource _appLocalDataSource;

  AppRepositoryImpl({required AppLocalDataSource appLocalDataSource})
    : _appLocalDataSource = appLocalDataSource;

  @override
  Future<Result<List<String>>> getSearchSuggestions() async {
    return await _appLocalDataSource.getSearchSuggestions();
  }

  @override
  Future<Result<bool>> getThemeMode() async {
    return await _appLocalDataSource.getThemeMode();
  }

  @override
  Future<Result<void>> setSearchSuggestions({
    required List<String> suggestions,
  }) async {
    return await _appLocalDataSource.setSearchSuggestions(
      suggestions: suggestions,
    );
  }

  @override
  Future<Result<void>> setThemeMode({required bool isDarkMode}) async {
    return await _appLocalDataSource.setThemeMode(isDarkMode: isDarkMode);
  }

  @override
  Future<Result<void>> updateSearchSuggestions({required String value}) async {
    return await _appLocalDataSource.updateSearchSuggestions(value: value);
  }
}
