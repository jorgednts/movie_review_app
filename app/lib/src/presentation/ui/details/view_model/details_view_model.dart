import 'package:app/src/data/remote/model/base/base_details_request_parameters.dart';
import 'package:app/src/domain/model/base_tmdb_details_model.dart';
import 'package:app/src/domain/model/cast_member_model.dart';
import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/domain/model/movie_model.dart';
import 'package:app/src/domain/model/tv_series_model.dart';
import 'package:app/src/domain/use_case/tmdb/get_cast_members_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_similar_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_similar_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_tmdb_item_details_use_case.dart';
import 'package:app/src/presentation/common/params/details_params.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

class DetailsViewModel extends BaseViewModel {
  final DetailsParams _params;
  final GetTMDBItemDetailsUseCase _getTMDBItemDetailsUseCase;
  final GetSimilarMoviesUseCase _getSimilarMoviesUseCase;
  final GetSimilarTVSeriesUseCase _getSimilarTVSeriesUseCase;
  final GetCastMembersUseCase _getCastMembersUseCase;

  DetailsViewModel({
    required DetailsParams params,
    required GetTMDBItemDetailsUseCase getTMDBItemDetailsUseCase,
    required GetSimilarMoviesUseCase getSimilarMoviesUseCase,
    required GetSimilarTVSeriesUseCase getSimilarTVSeriesUseCase,
    required GetCastMembersUseCase getCastMembersUseCase,
  }) : _params = params,
       _getTMDBItemDetailsUseCase = getTMDBItemDetailsUseCase,
       _getSimilarMoviesUseCase = getSimilarMoviesUseCase,
       _getSimilarTVSeriesUseCase = getSimilarTVSeriesUseCase,
       _getCastMembersUseCase = getCastMembersUseCase;

  // Commands
  late Command0<void> getDetails;
  late Command0<void> getSimilarMovies;
  late Command0<void> getSimilarTVSeries;
  late Command0<void> getCastMembers;

  Command0<void> get getSimilarItems => switch (_params.itemType) {
    AppCollectionItemType.movie => getSimilarMovies,
    AppCollectionItemType.tvSeries => getSimilarTVSeries,
  };

  // Other Variables
  BaseTMDBDetailsModel? details;
  final List<MovieModel> _similarMovies = List.empty(growable: true);
  final List<TVSeriesModel> _similarTVSeries = List.empty(growable: true);
  final List<CastMemberModel> castMembers = List.empty(growable: true);

  List get similarItems => switch (_params.itemType) {
    AppCollectionItemType.movie => _similarMovies,
    AppCollectionItemType.tvSeries => _similarTVSeries,
  };

  @override
  void onInit() {
    super.onInit();
    getDetails.execute();
    getCastMembers.execute();
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
      final result = await UrlLauncher.launchExternally(Uri.parse(details!.homepage!));
      result.fold(onOk: (result) {

      }, onError: (error) {
        debugPrint(error.toString());
      });
    }
  }
}
