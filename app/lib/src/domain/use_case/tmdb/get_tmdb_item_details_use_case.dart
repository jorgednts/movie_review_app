import 'package:app/src/data/remote/model/base/base_details_request_parameters.dart';
import 'package:app/src/domain/model/base_tmdb_details_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class GetTMDBItemDetailsUseCase
    implements BaseUseCase<BaseDetailsRequestParameters, BaseTMDBDetailsModel> {
  final TMDBRepository _tmdbRepository;

  GetTMDBItemDetailsUseCase({required TMDBRepository tmdbRepository})
    : _tmdbRepository = tmdbRepository;

  @override
  Future<Result<BaseTMDBDetailsModel>> call(
    BaseDetailsRequestParameters input,
  ) async {
    return await _tmdbRepository.getTMDBItemDetails(params: input);
  }
}
