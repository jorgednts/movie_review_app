import 'package:app/src/domain/repository/core_storage_repository.dart';
import 'package:app/src/domain/use_case/storage/add_item_to_collection_use_case.dart';
import 'package:app/src/domain/use_case/storage/delete_item_from_collection_use_case.dart';
import 'package:app/src/domain/use_case/storage/get_collection_from_storage_use_case.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/navigation/custom_shell_branch.dart';
import 'package:app/src/presentation/ui/reviews/view_model/reviews_view_model.dart';
import 'package:app/src/presentation/ui/reviews/widgets/reviews_view.dart';
import 'package:core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ReviewsDependency {
  static final dependency = CustomShellBranch(
    appRoute: AppRoute.reviews,
    routes: [
      GoRoute(
        path: AppRoute.reviews.path,
        name: AppRoute.reviews.name,
        builder:
            (context, state) => Provider(
              create: (context) {
                final coreStorageRepository =
                    context.read<CoreStorageRepository>();
                return ReviewsViewModel(
                  getCollectionFromStorageUseCase:
                      GetCollectionFromStorageUseCase(
                        coreStorageRepository: coreStorageRepository,
                      ),
                  addItemToCollectionUseCase: AddItemToCollectionUseCase(
                    coreStorageRepository: coreStorageRepository,
                  ),
                  deleteItemFromCollectionUseCase:
                      DeleteItemFromCollectionUseCase(
                        coreStorageRepository: coreStorageRepository,
                      ),
                  messageEventNotifier:
                      MessageEventNotifier<DefaultMessageType>(),
                );
              },
              child: const ReviewsView(),
            ),
      ),
    ],
  );
}
