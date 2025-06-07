import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class AppBarDetailSurfaceWidget extends StatelessWidget {
  final double voteAverage;
  final String overview;
  final String posterUrl;
  final BoxConstraints posterConstraints;

  const AppBarDetailSurfaceWidget({
    super.key,
    required this.voteAverage,
    required this.overview,
    required this.posterUrl,
    required this.posterConstraints,
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
            margin: EdgeInsets.only(right: Dimensions.spacingMd),
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
                  child: FiveStarsRating(rating: voteAverage),
                ),
                Flexible(
                  child: Row(
                    spacing: Dimensions.spacingMd,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: RoundedBorderButton(
                          icon: Icons.edit_note,
                          onPressed: () {},
                          tooltip: AppIntl.of(context).details_edit_review,
                        ),
                      ),
                      Flexible(
                        child: RoundedBorderButton(
                          icon: Icons.beenhere_outlined,
                          onPressed: () {},
                          tooltip: AppIntl.of(context).details_add_watchlist,
                        ),
                      ),
                      Flexible(
                        child: RoundedBorderButton(
                          icon: Icons.open_in_new,
                          onPressed: () {},
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
                child: CustomNetworkImage(url: posterUrl),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
