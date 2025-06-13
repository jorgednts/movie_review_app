import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:app/src/domain/repository/tmdb_repository.dart';
import 'package:app/src/domain/use_case/storage/add_item_to_collection_use_case.dart';
import 'package:app/src/domain/use_case/storage/check_item_in_collection_use_case.dart';
import 'package:app/src/domain/use_case/storage/delete_item_from_collection_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_cast_members_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_similar_movies_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_similar_tv_series_use_case.dart';
import 'package:app/src/domain/use_case/tmdb/get_tmdb_item_details_use_case.dart';
import 'package:app/src/presentation/common/params/details_params.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/ui/details/data/operation_command_request.dart';
import 'package:app/src/presentation/ui/details/view_model/details_view_model.dart';
import 'package:app/src/presentation/ui/details/widgets/details_view.dart';
import 'package:core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetailsDependency {
  static final dependency = GoRoute(
    path: '${AppRoute.details.path}/:itemId',
    name: AppRoute.details.name,
    builder: (context, state) {
      final params = state.uri.queryParameters;
      return Provider(
        create: (context) {
          final tmdbRepository = context.read<TMDBRepository>();
          final coreStorageRepository = context.read<CoreStorageRepository>();
          return DetailsViewModel(
            params: DetailsParams.fromJson(params),
            getTMDBItemDetailsUseCase: GetTMDBItemDetailsUseCase(
              tmdbRepository: tmdbRepository,
            ),
            getSimilarMoviesUseCase: GetSimilarMoviesUseCase(
              tmdbRepository: tmdbRepository,
            ),
            getSimilarTVSeriesUseCase: GetSimilarTVSeriesUseCase(
              tmdbRepository: tmdbRepository,
            ),
            getCastMembersUseCase: GetCastMembersUseCase(
              repository: tmdbRepository,
            ),
            addItemToCollectionUseCase: AddItemToCollectionUseCase(
              coreStorageRepository: coreStorageRepository,
            ),
            checkItemInCollectionUseCase: CheckItemInCollectionUseCase(
              coreStorageRepository: coreStorageRepository,
            ),
            deleteItemFromCollectionUseCase: DeleteItemFromCollectionUseCase(
              coreStorageRepository: coreStorageRepository,
            ),
            watchlistMessageEventNotifier:
                MessageEventNotifier<OperationMessageType>(),
            reviewMessageEventNotifier:
                MessageEventNotifier<OperationMessageType>(),
          );
        },
        child: const DetailsView(),
      );
    },
  );
}
