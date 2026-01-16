import 'package:app/src/domain/model/base_tmdb_details_model.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class ItemOverviewWidget extends StatelessWidget {
  const ItemOverviewWidget({super.key, required this.item});

  final BaseTMDBDetailsModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Dimensions.spacingMd,
      mainAxisSize: MainAxisSize.max,
      children: [
        DottedSpacedStringList(
          items: [
            item.releaseYear,
            item.originalLanguage.toUpperCase(),
            ...item.originCountry,
          ],
        ),
        if (item.genres.isNotEmpty) DottedSpacedStringList(items: item.genres),
        if (item.numberOfSeasons > 0)
          DottedSpacedStringList(
            items: [
              '${item.numberOfSeasons} ${item.numberOfSeasons > 1 ? AppIntl.of(context).details_seasons : AppIntl.of(context).details_season}',
            ],
          ),
        if (item.overview.isNotEmpty)
          ExpandableText(
            text: item.overview,
            initLines: 5,
            textAlign: TextAlign.end,
            seeLess: AppIntl.of(context).details_see_less,
            seeMore: AppIntl.of(context).details_see_more,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        else
          StyledText.b2(
            AppIntl.of(context).details_no_overview,
            isItalic: true,
          ),
      ],
    );
  }
}
