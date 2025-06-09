import 'package:app/src/domain/model/base_tmdb_details_model.dart';
import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class AppBarDetailSurfaceWidget extends StatelessWidget {
  final BaseTMDBDetailsModel item;
  final BoxConstraints posterConstraints;
  final void Function() onHomepagePressed;
  final bool showHomepageButton;
  final AppCollectionItemType type;
  final Widget watchlistButton;
  final Widget reviewButton;

  const AppBarDetailSurfaceWidget({
    super.key,
    required this.item,
    required this.posterConstraints,
    required this.onHomepagePressed,
    required this.showHomepageButton,
    required this.type,
    required this.watchlistButton,
    required this.reviewButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(right: Dimensions.spacingMd),
            constraints: BoxConstraints(maxHeight: posterConstraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: Dimensions.spacingSm,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(Dimensions.radiusLg),
                  ),
                  padding: const EdgeInsets.all(Dimensions.spacingSm),
                  child: FiveStarsRating(rating: item.voteAverage),
                ),
                Flexible(
                  child: Row(
                    spacing: Dimensions.spacingMd,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(child: reviewButton),
                      Flexible(child: watchlistButton),
                      if (showHomepageButton)
                        Flexible(
                          child: RoundedBorderButton(
                            icon: Icons.open_in_new,
                            onPressed: onHomepagePressed,
                            tooltip: AppIntl.of(context).details_visit_website,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: ConstrainedBox(
            constraints: posterConstraints,
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusLg),
                child: CustomNetworkImage(url: item.posterUrl),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
