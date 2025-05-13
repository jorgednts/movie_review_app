import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/use_case/get_popular_movies_use_case.dart';
import 'package:app/src/domain/use_case/get_popular_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/get_top_rated_movies_use_case.dart';
import 'package:app/src/domain/use_case/get_top_rated_tv_series_use_case.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends BaseViewModel {
  // Use Cases
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;
  final GetPopularTVSeriesUseCase _getPopularTVSeriesUseCase;
  final GetTopRatedMoviesUseCase _getTopRatedMoviesUseCase;
  final GetTopRatedTVSeriesUseCase _getTopRatedTVSeriesUseCase;

  HomeViewModel({
    required GetPopularMoviesUseCase getPopularMoviesUseCase,
    required GetPopularTVSeriesUseCase getPopularTVSeriesUseCase,
    required GetTopRatedMoviesUseCase getTopRatedMoviesUseCase,
    required GetTopRatedTVSeriesUseCase getTopRatedTVSeriesUseCase,
  }) : _getPopularMoviesUseCase = getPopularMoviesUseCase,
       _getPopularTVSeriesUseCase = getPopularTVSeriesUseCase,
       _getTopRatedMoviesUseCase = getTopRatedMoviesUseCase,
       _getTopRatedTVSeriesUseCase = getTopRatedTVSeriesUseCase;

  // Commands
  late final Command0<void> fetchPopularMovies;
  late final Command0<void> fetchPopularTVSeries;
  late final Command0<void> fetchTopRatedMovies;
  late final Command0<void> fetchTopRatedTVSeries;

  // Other Variables
  final List<MovieModel> popularMovies = [];
  final List<TVSeriesModel> popularTVSeries = [];
  final List<MovieModel> topRatedMovies = [];
  final List<TVSeriesModel> topRatedTVSeries = [];

  @override
  void onInit() {
    fetchPopularMovies = Command0(_getPopularMovies);
    fetchPopularTVSeries = Command0(_getPopularTVSeries);
    fetchTopRatedMovies = Command0(_getTopRatedMovies);
    fetchTopRatedTVSeries = Command0(_getTopRatedTVSeries);

    fetchPopularMovies.execute();
    fetchPopularTVSeries.execute();
    fetchTopRatedMovies.execute();
    fetchTopRatedTVSeries.execute();
  }

  Future<Result> _getPopularMovies() async {
    final response = await _getPopularMoviesUseCase.call(NoParam());
    response.handle(
      onOk: (result) {
        popularMovies.clear();
        popularMovies.addAll(result);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
    return response;
  }

  Future<Result<void>> _getPopularTVSeries() async {
    final response = await _getPopularTVSeriesUseCase.call(NoParam());
    response.handle(
      onOk: (result) {
        popularTVSeries.clear();
        popularTVSeries.addAll(result);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
    return response;
  }

  Future<Result> _getTopRatedMovies() async {
    final response = await _getTopRatedMoviesUseCase.call(NoParam());
    response.handle(
      onOk: (result) {
        topRatedMovies.clear();
        topRatedMovies.addAll(result);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
    return response;
  }

  Future<Result<void>> _getTopRatedTVSeries() async {
    final response = await _getTopRatedTVSeriesUseCase.call(NoParam());
    response.handle(
      onOk: (result) {
        topRatedTVSeries.clear();
        topRatedTVSeries.addAll(result);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
    return response;
  }
}
