import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/domain/model/app_collection_model.dart';
import 'package:app/src/presentation/ui/common/widgets/custom_loading_widget.dart';
import 'package:app/src/presentation/ui/common/widgets/login_required_widget.dart';
import 'package:app/src/presentation/ui/common/widgets/review_bottom_sheet.dart';
import 'package:app/src/presentation/ui/reviews/view_model/reviews_view_model.dart';
import 'package:app/src/presentation/ui/search/widgets/tmdb_overview_poster_card.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'package:provider/provider.dart';

class ReviewsView extends StatefulWidget {
  const ReviewsView({super.key});

  @override
  State<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  late UserStorageChangeNotifier userProvider;
  late ReviewsViewModel viewModel;
  bool initialized = false;

  void handleUserProvider() {
    if (userProvider.user != null && !initialized) {
      refresh();
      initialized = true;
    } else if (userProvider.user == null) {
      initialized = false;
    }
  }

  void showReviewBottomSheet(AppCollectionItemModel item) async {
    (await CustomModalNavigator.showCustomBottomSheet<AppCollectionItemModel?>(
      ReviewBottomSheet(item: item),
    )).fold(
      onOk: (result) {
        if (result != null) {
          viewModel.addReview.execute(
            CRUDItemRequest(
              uid: userProvider.user!.uid,
              collectionName: AppCollectionType.review.name,
              collectionItemModel: result,
            ),
          );
        }
      },
      onError: (error) {},
    );
  }

  void refresh() {
    viewModel.fetchList.execute(
      GetCollectionRequest(
        uid: userProvider.user!.uid,
        collectionName: AppCollectionType.review.name,
        fromJsonT: AppCollectionItemModel.fromStorage,
      ),
    );
  }

  void handleMessageEvent() {
    final messageEventType = viewModel.messageEventNotifier.consumeEvent();
    if (messageEventType != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        switch (messageEventType) {
          case DefaultMessageType.success:
            CustomScaffoldMessenger.showSuccessSnackBar(
              AppIntl.of(context).msg_operation_completed,
            );
            refresh();
            break;
          case DefaultMessageType.error:
            CustomScaffoldMessenger.showErrorSnackBar(
              AppIntl.of(context).msg_operation_not_completed,
            );
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = context.read<ReviewsViewModel>();
    userProvider = context.read<UserStorageChangeNotifier>();
    if (userProvider.user != null) {
      handleUserProvider();
    }
    userProvider.addListener(handleUserProvider);
  }

  @override
  void dispose() {
    userProvider.removeListener(handleUserProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultListenableGridView<
      AppCollectionItemModel,
      DefaultMessageType
    >(
      fetchList: viewModel.fetchList,
      userProvider: userProvider,
      messageEventNotifier: viewModel.messageEventNotifier,
      noUserWidget: LoginRequiredWidget(
        message: AppIntl.of(context).reviews_login_required_message,
      ),
      handleMessageEvent: handleMessageEvent,
      initStateWidget: const Center(child: CustomLoadingWidget()),
      loadingStateWidget: const Center(child: CustomLoadingWidget()),
      errorStateWidget: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: RetryButtonCard(
            message: AppIntl.of(context).msg_generic_error,
            messagePadding: const EdgeInsets.all(Dimensions.spacingMd),
            buttonText: AppIntl.of(context).common_try_again,
            onPressed: refresh,
          ),
        ),
      ),
      emptyStateWidget: Center(
        child: StackedIconCard(
          constraints: const BoxConstraints(maxWidth: 300),
          message: AppIntl.of(context).reviews_empty_state,
          icon: Icons.playlist_add,
        ),
      ),
      titleWidget: Row(
        children: [
          Text(
            AppIntl.of(context).reviews_my_reviews,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => refresh(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      itemBuilder:
          (item) => TMDBOverviewPosterCard(
            posterUrl: item.posterUrl,
            title: item.title,
            voteAverage: item.voteAverage,
            releaseYear: item.releaseYear,
            overview: item.review ?? '',
            onTap: () => showReviewBottomSheet(item),
            bottomTrailing: IconButton(
              onPressed:
                  () => viewModel.removeReview.execute(
                    CRUDItemRequest(
                      uid: userProvider.user!.uid,
                      collectionName: AppCollectionType.review.name,
                      collectionItemModel: item,
                    ),
                  ),
              icon: const Icon(Icons.delete_forever),
            ),
          ),
    );
  }
}
