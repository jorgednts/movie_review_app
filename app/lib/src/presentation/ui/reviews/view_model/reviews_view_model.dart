import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/domain/use_case/storage/add_item_to_collection_use_case.dart';
import 'package:app/src/domain/use_case/storage/delete_item_from_collection_use_case.dart';
import 'package:app/src/domain/use_case/storage/get_collection_from_storage_use_case.dart';
import 'package:core/core.dart';

class ReviewsViewModel extends BaseViewModel {
  final GetCollectionFromStorageUseCase _getCollectionFromStorageUseCase;
  final AddItemToCollectionUseCase _addItemToCollectionUseCase;
  final DeleteItemFromCollectionUseCase _deleteItemFromCollectionUseCase;
  final MessageEventNotifier<DefaultMessageType> messageEventNotifier;

  ReviewsViewModel({
    required GetCollectionFromStorageUseCase getCollectionFromStorageUseCase,
    required AddItemToCollectionUseCase addItemToCollectionUseCase,
    required DeleteItemFromCollectionUseCase deleteItemFromCollectionUseCase,
    required this.messageEventNotifier,
  }) : _getCollectionFromStorageUseCase = getCollectionFromStorageUseCase,
       _addItemToCollectionUseCase = addItemToCollectionUseCase,
       _deleteItemFromCollectionUseCase = deleteItemFromCollectionUseCase;

  late Command1<
    List<CollectionItemModel>,
    GetCollectionRequest<AppCollectionItemModel>
  >
  fetchList;
  late Command1<bool, CRUDItemRequest<AppCollectionItemModel>> addReview;
  late Command1<bool, CRUDItemRequest<AppCollectionItemModel>> removeReview;

  @override
  void initCommands() {
    fetchList = Command1(_fetchReviews);
    addReview = Command1(_addReview);
    removeReview = Command1(_removeReview);
  }

  AsyncResult<List<AppCollectionItemModel>> _fetchReviews(
    GetCollectionRequest<AppCollectionItemModel> request,
  ) async {
    return await _getCollectionFromStorageUseCase.call(request);
  }

  AsyncResult<bool> _addReview(
    CRUDItemRequest<AppCollectionItemModel> input,
  ) async {
    return await callUseCase(
      useCase: _addItemToCollectionUseCase,
      input: input,
      onSuccess: (result) {
        messageEventNotifier.trigger(DefaultMessageType.success);
      },
      onError: (error) {
        messageEventNotifier.trigger(DefaultMessageType.error);
      },
    );
  }

  AsyncResult<bool> _removeReview(
    CRUDItemRequest<AppCollectionItemModel> input,
  ) async {
    return await callUseCase(
      useCase: _deleteItemFromCollectionUseCase,
      input: input,
      onSuccess: (result) {
        messageEventNotifier.trigger(DefaultMessageType.success);
      },
      onError: (error) {
        messageEventNotifier.trigger(DefaultMessageType.error);
      },
    );
  }
}
