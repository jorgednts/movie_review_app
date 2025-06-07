import 'package:core/core.dart';

abstract class BaseUseCase<InputType, OutputType> {
  AsyncResult<OutputType> call(InputType input);
}

class NoParam {}
