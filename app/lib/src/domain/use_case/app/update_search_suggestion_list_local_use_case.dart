import 'package:app/src/domain/repository/app_repository.dart';
import 'package:core/core.dart';

class UpdateSearchSuggestionListLocalUseCase extends BaseUseCase<String, void> {
  final AppRepository _appRepository;

  UpdateSearchSuggestionListLocalUseCase({required AppRepository appRepository})
    : _appRepository = appRepository;

  @override
  AsyncResult<void> call(String input) async {
    return await _appRepository.updateSearchSuggestions(value: input);
  }
}
