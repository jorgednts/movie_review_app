import 'package:app/src/domain/repository/app_repository.dart';
import 'package:core/core.dart';

class GetSearchSuggestionListLocalUseCase
    extends BaseUseCase<NoParam, List<String>> {
  final AppRepository _appRepository;

  GetSearchSuggestionListLocalUseCase({required AppRepository appRepository})
    : _appRepository = appRepository;

  @override
  Future<Result<List<String>>> call(NoParam input) async {
    return await _appRepository.getSearchSuggestions();
  }
}
