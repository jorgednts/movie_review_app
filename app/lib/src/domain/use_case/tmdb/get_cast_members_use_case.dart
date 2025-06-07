import 'package:app/src/data/remote/model/base/base_details_request_parameters.dart';
import 'package:app/src/domain/model/cast_member_model.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:core/core.dart';

class GetCastMembersUseCase
    implements
        BaseUseCase<BaseDetailsRequestParameters, List<CastMemberModel>> {
  final TMDBRepository _repository;

  GetCastMembersUseCase({required TMDBRepository repository})
    : _repository = repository;

  @override
  AsyncResult<List<CastMemberModel>> call(
    BaseDetailsRequestParameters input,
  ) async {
    return await _repository.getCastMembers(params: input);
  }
}
