import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class GetPopularMoviesUseCase
    implements BaseUseCase<NoParam, List<MovieModel>> {
  final TMDBRepository _tmdbRepository;

  GetPopularMoviesUseCase({required TMDBRepository tmdbRepository})
    : _tmdbRepository = tmdbRepository;

  @override
  AsyncResult<List<MovieModel>> call(NoParam input) async {
    return await _tmdbRepository.getPopularMovies();
  }
}
