import 'package:core/src/utils/result.dart';

abstract class BaseUseCase<InputType, OutputType> {
  Future<Result<OutputType>> call(InputType input);
}

class NoParam {}
