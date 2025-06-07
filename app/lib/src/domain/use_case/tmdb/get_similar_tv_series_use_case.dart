import 'package:app/src/data/remote/model/base/base_details_request_parameters.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class GetSimilarTVSeriesUseCase
    implements BaseUseCase<BaseDetailsRequestParameters, List<TVSeriesModel>> {
  final TMDBRepository _tmdbRepository;

  GetSimilarTVSeriesUseCase({required TMDBRepository tmdbRepository})
    : _tmdbRepository = tmdbRepository;

  @override
  AsyncResult<List<TVSeriesModel>> call(
    BaseDetailsRequestParameters input,
  ) async {
    return await _tmdbRepository.getSimilarTVSeries(params: input);
  }
}
