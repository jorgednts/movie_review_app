import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:core/core.dart';

enum OperationType { add, remove, check }

enum OperationMessageType {
  success,
  error,
}

class OperationCommandRequest {
  final OperationType operationType;
  final CRUDItemRequest<AppCollectionItemModel>? crudItemRequest;

  OperationCommandRequest({required this.operationType, this.crudItemRequest})
    : assert(operationType == OperationType.check || crudItemRequest != null);
}
