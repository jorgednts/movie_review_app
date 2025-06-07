import 'dart:math';

import 'package:app/src/presentation/ui/common/widgets/custom_loading_widget.dart';
import 'package:app/src/presentation/ui/details/view_model/details_view_model.dart';
import 'package:app/src/presentation/ui/details/widgets/app_bar_detail_surface_widget.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
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
          if (viewModel.getDetails.running) {
            return const Center(child: CustomLoadingWidget());
          }
          final item = viewModel.details;
          return DefaultCollapsableAppBarView(
            expandedHeight: expandedHeight,
            title: item?.title ?? '',
            appBarBackground: CustomNetworkImage(url: item?.backdropUrl ?? ''),
            appBarSurfaceWidget:
                item == null
                    ? null
                    : AppBarDetailSurfaceWidget(
                      overview: item.overview,
                      voteAverage: item.voteAverage,
                      posterConstraints: BoxConstraints(
                        maxHeight: expandedHeight * 0.6,
                      ),
                      posterUrl: item.posterUrl,
                    ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Dimensions.spacingMd,
                children:
                    item == null
                        ? []
                        : [
                          DottedSpacedStringList(
                            items: [
                              item.releaseYear,
                              item.originalLanguage.toUpperCase(),
                              ...item.originCountry,
                            ],
                          ),
                          DottedSpacedStringList(items: item.genres),
                          if (item.numberOfSeasons > 0)
                            DottedSpacedStringList(
                              items: [
                                '${item.numberOfSeasons} ${item.numberOfSeasons > 1 ? AppIntl.of(context).details_seasons : AppIntl.of(context).details_season}',
                              ],
                            ),
                          Text(
                            item.overview,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
              ),
            ),
          );
        },
      ),
    );
  }
}
