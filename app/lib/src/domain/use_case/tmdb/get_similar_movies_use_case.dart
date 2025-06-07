import 'package:app/src/data/remote/model/base/base_details_request_parameters.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class GetSimilarMoviesUseCase
    implements BaseUseCase<BaseDetailsRequestParameters, List<MovieModel>> {
  final TMDBRepository _tmdbRepository;

  GetSimilarMoviesUseCase({required TMDBRepository tmdbRepository})
    : _tmdbRepository = tmdbRepository;

  @override
  AsyncResult<List<MovieModel>> call(BaseDetailsRequestParameters input) async {
    return await _tmdbRepository.getSimilarMovies(params: input);
  }
}
