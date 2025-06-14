import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/domain/model/app_collection_model.dart';
import 'package:app/src/presentation/navigation/app_navigator.dart';
import 'package:app/src/presentation/ui/common/widgets/custom_loading_widget.dart';
import 'package:app/src/presentation/ui/common/widgets/login_required_widget.dart';
import 'package:app/src/presentation/ui/search/widgets/tmdb_overview_poster_card.dart';
import 'package:app/src/presentation/ui/watchlist/view_model/watchlist_view_model.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'package:provider/provider.dart';

class WatchlistView extends StatefulWidget {
  const WatchlistView({super.key});

  @override
  State<WatchlistView> createState() => _WatchlistViewState();
}

class _WatchlistViewState extends State<WatchlistView> {
  late UserStorageChangeNotifier userProvider;
  late WatchlistViewModel viewModel;
  bool initialized = false;

  void handleUserProvider() {
    if (userProvider.user != null && !initialized) {
      refresh();
      initialized = true;
    } else if (userProvider.user == null) {
      initialized = false;
    }
  }

  void refresh() {
    viewModel.fetchList.execute(
      GetCollectionRequest(
        uid: userProvider.user!.uid,
        collectionName: AppCollectionType.watchlist.name,
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
    viewModel = context.read<WatchlistViewModel>();
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
        message: AppIntl.of(context).watchlist_login_required_message,
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
          message: AppIntl.of(context).watchlist_empty_state,
          icon: Icons.playlist_add,
        ),
      ),
      titleWidget: Row(
        children: [
          StyledText.h2(
            AppIntl.of(context).watchlist_my_watchlist,
            isBold: true,
          ),
          const Spacer(),
          IconButton(onPressed: refresh, icon: const Icon(Icons.refresh)),
        ],
      ),
      itemBuilder: (item) {
        return TMDBOverviewPosterCard(
          posterUrl: item.posterUrl,
          title: item.title,
          voteAverage: item.voteAverage,
          releaseYear: item.releaseYear,
          overview: item.overview,
          onTap: () {
            context.navigateToDetails(
              item.tmdbId.toString(),
              item.type,
              item.id,
            );
          },
          bottomTrailing: IconButton(
            onPressed: () {
              viewModel.removeFromWatchlist.execute(
                CRUDItemRequest(
                  uid: userProvider.user!.uid,
                  collectionName: AppCollectionType.watchlist.name,
                  collectionItemModel: item,
                ),
              );
            },
            icon: const Icon(Icons.delete_forever),
          ),
        );
      },
    );
  }
}
