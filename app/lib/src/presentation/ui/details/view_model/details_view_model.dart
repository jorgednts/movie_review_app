import 'package:app/src/data/remote/model/base/base_details_request_parameters.dart';
import 'package:app/src/domain/model/app_collection_model.dart';
import 'package:app/src/domain/model/base_tmdb_details_model.dart';
import 'package:app/src/domain/model/cast_member_model.dart';
import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/use_case/storage/add_item_to_collection_use_case.dart';
import 'package:app/src/domain/use_case/storage/check_item_in_collection_use_case.dart';
import 'package:app/src/domain/use_case/storage/delete_item_from_collection_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_cast_members_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_similar_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_similar_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_tmdb_item_details_use_case.dart';
import 'package:app/src/presentation/common/params/details_params.dart';
import 'package:app/src/presentation/ui/details/data/operation_command_request.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

class DetailsViewModel extends BaseViewModel {
  final DetailsParams _params;
  final GetTMDBItemDetailsUseCase _getTMDBItemDetailsUseCase;
  final GetSimilarMoviesUseCase _getSimilarMoviesUseCase;
  final GetSimilarTVSeriesUseCase _getSimilarTVSeriesUseCase;
  final GetCastMembersUseCase _getCastMembersUseCase;
  final AddItemToCollectionUseCase _addItemToCollectionUseCase;
  final CheckItemInCollectionUseCase _checkItemInCollectionUseCase;
  final DeleteItemFromCollectionUseCase _deleteItemFromCollectionUseCase;
  final MessageEventNotifier<OperationMessageType>
  watchlistMessageEventNotifier;
  final MessageEventNotifier<OperationMessageType> reviewMessageEventNotifier;

  DetailsViewModel({
    required DetailsParams params,
    required GetTMDBItemDetailsUseCase getTMDBItemDetailsUseCase,
    required GetSimilarMoviesUseCase getSimilarMoviesUseCase,
    required GetSimilarTVSeriesUseCase getSimilarTVSeriesUseCase,
    required GetCastMembersUseCase getCastMembersUseCase,
    required AddItemToCollectionUseCase addItemToCollectionUseCase,
    required CheckItemInCollectionUseCase checkItemInCollectionUseCase,
    required DeleteItemFromCollectionUseCase deleteItemFromCollectionUseCase,
    required this.watchlistMessageEventNotifier,
    required this.reviewMessageEventNotifier,
  }) : _params = params,
       _getTMDBItemDetailsUseCase = getTMDBItemDetailsUseCase,
       _getSimilarMoviesUseCase = getSimilarMoviesUseCase,
       _getSimilarTVSeriesUseCase = getSimilarTVSeriesUseCase,
       _getCastMembersUseCase = getCastMembersUseCase,
       _addItemToCollectionUseCase = addItemToCollectionUseCase,
       _checkItemInCollectionUseCase = checkItemInCollectionUseCase,
       _deleteItemFromCollectionUseCase = deleteItemFromCollectionUseCase;

  //************* Commands **************
  late Command0<void> getDetails;
  late Command0<void> getSimilarMovies;
  late Command0<void> getSimilarTVSeries;
  late Command0<void> getCastMembers;
  late Command1<bool, OperationCommandRequest> handleWatchlistOperation;
  late Command1<bool, OperationCommandRequest> handleReviewOperation;

  Command0<void> get getSimilarItems => switch (_params.itemType) {
    AppCollectionItemType.movie => getSimilarMovies,
    AppCollectionItemType.tvSeries => getSimilarTVSeries,
  };

  //*************************************

  //********* Other Variables ***********
  BaseTMDBDetailsModel? details;
  final List<MovieModel> _similarMovies = List.empty(growable: true);
  final List<TVSeriesModel> _similarTVSeries = List.empty(growable: true);
  final List<CastMemberModel> castMembers = List.empty(growable: true);

  List get similarItems => switch (_params.itemType) {
    AppCollectionItemType.movie => _similarMovies,
    AppCollectionItemType.tvSeries => _similarTVSeries,
  };

  AppCollectionItemType get type => _params.itemType;

  //***************************************

  @override
  void onInit() {
    super.onInit();
    getDetails.execute();
    getCastMembers.execute();
    if (_params.uid?.isNotEmpty ?? false) {
      handleWatchlistOperation.execute(
        OperationCommandRequest(operationType: OperationType.check),
      );
      handleReviewOperation.execute(
        OperationCommandRequest(operationType: OperationType.check),
      );
    }
    switch (_params.itemType) {
      case AppCollectionItemType.movie:
        getSimilarMovies.execute();
        break;
      case AppCollectionItemType.tvSeries:
        getSimilarTVSeries.execute();
        break;
    }
  }

  @override
  void initCommands() {
    getDetails = Command0<void>(_getDetails);
    getSimilarMovies = Command0<void>(_getSimilarMovies);
    getSimilarTVSeries = Command0<void>(_getSimilarTVSeries);
    getCastMembers = Command0<void>(_getCastMembers);
    handleWatchlistOperation = Command1<bool, OperationCommandRequest>(
      _handleWatchlist,
    );
    handleReviewOperation = Command1<bool, OperationCommandRequest>(
      _handleReview,
    );
  }

  AsyncResult _getDetails() async {
    return await callUseCase<
      BaseDetailsRequestParameters,
      BaseTMDBDetailsModel
    >(
      useCase: _getTMDBItemDetailsUseCase,
      input: BaseDetailsRequestParameters(
        id: _params.itemId,
        type: _params.itemType,
        language: _params.language,
      ),
      onSuccess: (result) {
        details = result;
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }

  AsyncResult _getSimilarMovies() async {
    return await callUseCase<BaseDetailsRequestParameters, List<MovieModel>>(
      useCase: _getSimilarMoviesUseCase,
      input: BaseDetailsRequestParameters(
        id: _params.itemId,
        type: _params.itemType,
        language: _params.language,
      ),
      onSuccess: (result) {
        _similarMovies.clear();
        _similarMovies.addAll(result);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }

  AsyncResult _getSimilarTVSeries() async {
    return await callUseCase<BaseDetailsRequestParameters, List<TVSeriesModel>>(
      useCase: _getSimilarTVSeriesUseCase,
      input: BaseDetailsRequestParameters(
        id: _params.itemId,
        type: _params.itemType,
        language: _params.language,
      ),
      onSuccess: (result) {
        _similarTVSeries.clear();
        _similarTVSeries.addAll(result);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }

  AsyncResult _getCastMembers() async {
    return await callUseCase<
      BaseDetailsRequestParameters,
      List<CastMemberModel>
    >(
      useCase: _getCastMembersUseCase,
      input: BaseDetailsRequestParameters(
        id: _params.itemId,
        type: _params.itemType,
        language: _params.language,
      ),
      onSuccess: (result) {
        castMembers.clear();
        castMembers.addAll(result);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }

  void launchUrl() async {
    if (details?.homepage != null && (details!.homepage?.isNotEmpty ?? false)) {
      final result = await UrlLauncher.launchExternally(
        Uri.parse(details!.homepage!),
      );
      result.fold(
        onOk: (result) {},
        onError: (error) {
          debugPrint(error.toString());
        },
      );
    }
  }

  AsyncResult<bool> _addItemToCollection(
    CRUDItemRequest<AppCollectionItemModel> input,
  ) async {
    return await callUseCase<CRUDItemRequest<AppCollectionItemModel>, bool>(
      useCase: _addItemToCollectionUseCase,
      input: input,
      onSuccess: (result) {
        triggerMessageEvent(OperationMessageType.success, input.collectionName);
      },
      onError: (error) {
        triggerMessageEvent(OperationMessageType.error, input.collectionName);
      },
    );
  }

  AsyncResult<bool> _deleteItemFromCollection(
    CRUDItemRequest<AppCollectionItemModel> input,
  ) async {
    return await callUseCase<CRUDItemRequest<AppCollectionItemModel>, bool>(
      useCase: _deleteItemFromCollectionUseCase,
      input: input,
      onSuccess: (result) {
        triggerMessageEvent(OperationMessageType.success, input.collectionName);
      },
      onError: (error) {
        triggerMessageEvent(OperationMessageType.error, input.collectionName);
      },
    );
  }

  AsyncResult<bool> _checkWatchlist(CheckItemRequest input) async {
    return await callUseCase<CheckItemRequest, bool>(
      useCase: _checkItemInCollectionUseCase,
      input: input,
      onSuccess: (result) {},
      onError: (error) {},
    );
  }

  AsyncResult<bool> _checkReviews(CheckItemRequest input) async {
    return await callUseCase<CheckItemRequest, bool>(
      useCase: _checkItemInCollectionUseCase,
      input: input,
      onSuccess: (result) {},
      onError: (error) {},
    );
  }

  AsyncResult<bool> _handleWatchlist(OperationCommandRequest request) async {
    switch (request.operationType) {
      case OperationType.add:
        return _addItemToCollection(request.crudItemRequest!);
      case OperationType.remove:
        return _deleteItemFromCollection(request.crudItemRequest!);
      case OperationType.check:
        return _checkWatchlist(
          _params.toCheckItemRequest(AppCollectionType.watchlist.name),
        );
    }
  }

  AsyncResult<bool> _handleReview(OperationCommandRequest request) async {
    switch (request.operationType) {
      case OperationType.add:
        return _addItemToCollection(request.crudItemRequest!);
      case OperationType.remove:
        return _deleteItemFromCollection(request.crudItemRequest!);
      case OperationType.check:
        return _checkReviews(
          _params.toCheckItemRequest(AppCollectionType.review.name),
        );
    }
  }

  void triggerMessageEvent(
    OperationMessageType messageType,
    String collectionType,
  ) {
    if (collectionType == AppCollectionType.watchlist.name) {
      switch (messageType) {
        case OperationMessageType.success:
          watchlistMessageEventNotifier.trigger(OperationMessageType.success);
          break;
        case OperationMessageType.error:
          watchlistMessageEventNotifier.trigger(OperationMessageType.error);
      }
    } else {
      switch (messageType) {
        case OperationMessageType.success:
          reviewMessageEventNotifier.trigger(OperationMessageType.success);
          break;
        case OperationMessageType.error:
          reviewMessageEventNotifier.trigger(OperationMessageType.success);
      }
    }
  }
}
