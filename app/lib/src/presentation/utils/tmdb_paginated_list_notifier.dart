import 'package:app/src/domain/model/base_tmdb_paginated_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

typedef MoviePaginatedListNotifier = TMDBPaginatedListNotifier<MovieModel>;
typedef TVSeriesPaginatedListNotifier =
    TMDBPaginatedListNotifier<TVSeriesModel>;

typedef TMDBPaginatedFetcher<T> =
    AsyncResult<BaseTMDBPaginatedModel<T>> Function(int page);

class TMDBPaginatedListNotifier<T> extends ChangeNotifier {
  final List<T> _items = [];
  final TMDBPaginatedFetcher<T> _fetcher;

  int _currentPage = 0;
  int _totalItems = 0;
  bool _hasMore = true;
  bool _isLoading = false;
  Exception? _error;

  TMDBPaginatedListNotifier(this._fetcher);

  List<T> get items => _items;

  bool get hasMore => _hasMore;

  int get currentPage => _currentPage;

  int get totalItems => _totalItems;

  bool get isLoading => _isLoading;

  Exception? get error => _error;

  AsyncResult<void> loadNextPage() async {
    if (_isLoading || !_hasMore) return const Result.ok(null);

    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _fetcher(_currentPage);

    switch (result) {
      case Ok(:final value):
        if (_totalItems == 0) {
          _totalItems = value.totalResults;
        }
        _hasMore = value.page < value.totalPages;
        if (_items.length < _totalItems) {
          _items.addAll(value.results);
          _currentPage++;
        }
        break;

      case Error(:final error):
        _error = error;
        return Result.error(error);
    }

    _isLoading = false;
    notifyListeners();
    return const Result.ok(null);
  }

  void reset() {
    _items.clear();
    _currentPage = 1;
    _totalItems = 0;
    _hasMore = true;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}
