import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

typedef PaginatedFetcher<T> = Future<Result<List<T>>> Function(int page);

class PaginatedListNotifier<T> extends ChangeNotifier {
  final List<T> _items = [];
  final PaginatedFetcher<T> _fetcher;

  int _currentPage = 0;
  bool _hasMore = true;
  bool _isLoading = false;
  Exception? _error;

  PaginatedListNotifier(this._fetcher);

  List<T> get items => _items;

  bool get hasMore => _hasMore;

  int get currentPage => _currentPage;

  bool get isLoading => _isLoading;

  Exception? get error => _error;

  Future<Result<void>> loadNextPage() async {
    if (_isLoading || !_hasMore) return const Result.ok(null);

    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _fetcher(_currentPage);

    switch (result) {
      case Ok(:final value):
        if (value.isEmpty) {
          _hasMore = false;
        } else {
          _items.addAll(value);
          _currentPage++;
        }
        break;

      case Error(:final error):
        _isLoading = false;
        _error = error;
        notifyListeners();
        return Result.error(error);
    }

    _isLoading = false;
    notifyListeners();
    return const Result.ok(null);
  }

  void reset() {
    _items.clear();
    _currentPage = 1;
    _hasMore = true;
    _isLoading = false;
    notifyListeners();
  }
}
