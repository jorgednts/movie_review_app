import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/use_case/get_popular_movies_use_case.dart';
import 'package:core/core.dart';

class HomeViewModel extends BaseViewModel {
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;

  HomeViewModel({required GetPopularMoviesUseCase getPopularMoviesUseCase})
    : _getPopularMoviesUseCase = getPopularMoviesUseCase;

  late final Command0<void> getPopularMoviesCommand;

  final List<MovieModel> movies = [];

  @override
  Future<void> onInit() async {
    getPopularMoviesCommand = Command0(_getPopularMovies);
    getPopularMoviesCommand.execute();
  }

  Future<Result<void>> _getPopularMovies() async {
    final result = await _getPopularMoviesUseCase.call();
    switch (result) {
      case Ok<List<MovieModel>>():
        movies.clear();
        movies.addAll(result.value);
        return Result.ok(null);
      case Error<List<MovieModel>>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
