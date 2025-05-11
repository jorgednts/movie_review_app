import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class GetPopularMoviesUseCase {
  final TMDBRepository _tmdbRepository;

  GetPopularMoviesUseCase({required TMDBRepository tmdbRepository})
    : _tmdbRepository = tmdbRepository;

  Future<Result<List<MovieModel>>> call() async {
    return await _tmdbRepository.getPopularMovies();
  }
}
