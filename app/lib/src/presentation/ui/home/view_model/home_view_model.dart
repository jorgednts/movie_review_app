import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/use_case/tmdb/get_popular_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_popular_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_top_rated_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_top_rated_tv_series_use_case.dart';
import 'package:core/core.dart';

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
  late final Command0<List<MovieModel>> fetchPopularMovies;
  late final Command0<List<TVSeriesModel>> fetchPopularTVSeries;
  late final Command0<List<MovieModel>> fetchTopRatedMovies;
  late final Command0<List<TVSeriesModel>> fetchTopRatedTVSeries;

  @override
  void onInit() {
    super.onInit();

    fetchPopularMovies.execute();
    fetchPopularTVSeries.execute();
    fetchTopRatedMovies.execute();
    fetchTopRatedTVSeries.execute();
  }

  @override
  void initCommands() {
    fetchPopularMovies = Command0(_getPopularMovies);
    fetchPopularTVSeries = Command0(_getPopularTVSeries);
    fetchTopRatedMovies = Command0(_getTopRatedMovies);
    fetchTopRatedTVSeries = Command0(_getTopRatedTVSeries);
  }

  AsyncResult<List<MovieModel>> _getPopularMovies() async {
    return await _getPopularMoviesUseCase(NoParam());
  }

  AsyncResult<List<TVSeriesModel>> _getPopularTVSeries() async {
    return await _getPopularTVSeriesUseCase(NoParam());
  }

  AsyncResult<List<MovieModel>> _getTopRatedMovies() async {
    return await _getTopRatedMoviesUseCase(NoParam());
  }

  AsyncResult<List<TVSeriesModel>> _getTopRatedTVSeries() async {
    return await _getTopRatedTVSeriesUseCase(NoParam());
  }
}
