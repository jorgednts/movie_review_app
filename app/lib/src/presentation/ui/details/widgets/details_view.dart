import 'dart:math';

import 'package:app/src/domain/model/app_collection_model.dart';
import 'package:app/src/presentation/ui/common/widgets/collection_operation_button.dart';
import 'package:app/src/presentation/ui/common/widgets/custom_loading_widget.dart';
import 'package:app/src/presentation/ui/details/view_model/details_view_model.dart';
import 'package:app/src/presentation/ui/details/widgets/app_bar_detail_surface_widget.dart';
import 'package:app/src/presentation/ui/details/widgets/cast_members_widget.dart';
import 'package:app/src/presentation/ui/details/widgets/item_overview_widget.dart';
import 'package:app/src/presentation/ui/details/widgets/similar_items_widget.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<DetailsViewModel>();
    final expandedHeight = max(MediaQuery.sizeOf(context).height * 0.4, 400.0);

    return Scaffold(
      body: ListenableBuilder(
        listenable: viewModel.getDetails,
        builder: (context, child) {
          final item = viewModel.details;
          return DefaultCollapsableAppBarView(
            expandedHeight: expandedHeight,
            title: item?.title ?? '',
            appBarBackground: switch (viewModel.getDetails.state) {
              CommandState.init => const Center(child: CustomLoadingWidget()),
              CommandState.loading => const Center(
                child: CustomLoadingWidget(),
              ),
              CommandState.error => CustomNetworkImage(
                url: item?.backdropUrl ?? '',
              ),
              CommandState.completed => CustomNetworkImage(
                url: item?.backdropUrl ?? '',
              ),
            },
            appBarSurfaceWidget:
                item == null
                    ? null
                    : AppBarDetailSurfaceWidget(
                      item: item,
                      type: viewModel.type,
                      posterConstraints: BoxConstraints(
                        maxHeight: expandedHeight * 0.6,
                      ),
                      onHomepagePressed: viewModel.launchUrl,
                      showHomepageButton:
                          viewModel.details?.homepage?.isNotEmpty ?? false,
                      reviewButton: CollectionOperationButton(
                        commandOperation: viewModel.handleReviewOperation,
                        messageEventNotifier: viewModel.watchlistMessageEventNotifier,
                        collectionType: AppCollectionType.review,
                        item: item,
                        itemType: viewModel.type,
                      ),
                      watchlistButton: CollectionOperationButton(
                        messageEventNotifier: viewModel.watchlistMessageEventNotifier,
                        commandOperation: viewModel.handleWatchlistOperation,
                        collectionType: AppCollectionType.watchlist,
                        item: item,
                        itemType: viewModel.type,
                      ),
                    ),
            body: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (_, constraints) {
                  final width =
                      WindowUtils.isDesktop(context)
                          ? (constraints.maxWidth / 2) - Dimensions.spacingMd
                          : double.infinity;
                  return Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: Dimensions.spacingMd,
                    children:
                        item == null
                            ? [const Center(child: CustomLoadingWidget())]
                            : [
                              Container(
                                width: width * 0.8,
                                padding: const EdgeInsets.only(
                                  right: Dimensions.spacingMd,
                                ),
                                child: ItemOverviewWidget(item: item),
                              ),
                              SizedBox(
                                width: width * 1.2,
                                child: CastMembersWidget(
                                  castMembers: viewModel.castMembers,
                                  getCastMembers: viewModel.getCastMembers,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                  vertical: Dimensions.spacingMd,
                                ),
                                child: SimilarItemsWidget(
                                  getSimilarItems: viewModel.getSimilarItems,
                                  items: viewModel.similarItems,
                                ),
                              ),
                            ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
