import 'package:app/src/data/local/data_source/app_local_data_source.dart';
import 'package:app/src/data/local/data_source/prefs_constants/prefs_constants.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalDataSourceImpl implements AppLocalDataSource {
  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> _prefs() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  @override
  Future<Result<List<String>>> getSearchSuggestions() async {
    try {
      final result = (await _prefs()).getStringList(
        PrefsConstants.searchSuggestionsKey,
      );
      return Result.ok(result ?? []);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<bool>> getThemeMode() async {
    try {
      final result = (await _prefs()).getBool(PrefsConstants.themeModeKey);
      return Result.ok(result ?? ThemeMode.system == ThemeMode.dark);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> setSearchSuggestions({
    required List<String> suggestions,
  }) async {
    try {
      final result = await (await _prefs()).setStringList(
        PrefsConstants.searchSuggestionsKey,
        suggestions,
      );
      if (result) {
        return Result.ok(null);
      }
      return Result.error(Exception());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> updateSearchSuggestions({required String value}) async {
    try {
      final currentList = await getSearchSuggestions();
      switch (currentList) {
        case Ok<List<String>>():
          if (currentList.value.contains(value)) {
            return Result.ok(null);
          }
          if (currentList.value.length == 10) {
            currentList.value.removeAt(0);
          }
          currentList.value.add(value);

          final result = await (await _prefs()).setStringList(
            PrefsConstants.searchSuggestionsKey,
            currentList.value,
          );
          if (result) {
            return Result.ok(null);
          }
          return Result.error(Exception());
        case Error<List<String>>():
          return Result.error(currentList.error);
      }
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> setThemeMode({required bool isDarkMode}) async {
    try {
      final result = await (await _prefs()).setBool(
        PrefsConstants.themeModeKey,
        isDarkMode,
      );
      if (result) {
        return Result.ok(null);
      }
      return Result.error(Exception());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
